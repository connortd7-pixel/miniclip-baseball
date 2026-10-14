// Minimal Flash (AS2-era) display-list player for the timelines extracted by
// tools/extract_swf.py into assets/swf/swf.js.
//
// It covers what the field view needs: nested MovieClips with their own
// timelines and labels, timeline place/move/remove, script overrides of
// _x/_y/_xscale/_yscale/_alpha/_visible (which detach a child from timeline
// moves, as in Flash), attachMovie by linkage name, buttons drawn from their
// exported state PNGs, static and dynamic text, timeline sounds (handed to
// SWFPlayer.onSound when their frame is entered), and frame actions: plain
// stop()/play()/goto run directly, anything else calls a hook registered with
// SWFPlayer.hook(spriteId, frame, fn).
//
// Masks (clipDepth) are drawn by rendering the masked layers to an offscreen
// canvas and cutting them with the mask's shape (destination-in). A colour
// transform set through .tint (AS2 `transform.colorTransform = ct` with ct.rgb set:
// colour multipliers 0, offsets = the colour) is drawn the same way, the layer
// filled with the colour where it is opaque (source-in).
(function(){
'use strict';
const S = window.SWF;
const BASE = 'assets/swf/';
const IDENTITY = [1,0,0,1,0,0];
const SCRIPT_DEPTH = 1 << 20;

const images = {};          // shape id -> Image (svg)
const buttonImages = {};    // `${id}_${state}` -> Image (png)
const hooks = {};           // `${spriteId}:${frame}` -> fn(clip)
const warned = new Set();

function mul(p, q){         // p ∘ q  (apply q, then p)
  return [p[0]*q[0]+p[2]*q[1], p[1]*q[0]+p[3]*q[1],
          p[0]*q[2]+p[2]*q[3], p[1]*q[2]+p[3]*q[3],
          p[0]*q[4]+p[2]*q[5]+p[4], p[1]*q[4]+p[3]*q[5]+p[5]];
}
function alphaOf(a){ return a ? Math.max(0, Math.min(1, a[0] + a[1]/255)) : 1; }

function handle(ch){
  return {
    entry: ch,
    get _visible(){ return ch.visible !== false; }, set _visible(v){ ch.visible = !!v; },
    get _x(){ return ch.m[4]; }, set _x(v){ ch.m = ch.m.slice(); ch.m[4] = v; ch.scripted = true; },
    get _y(){ return ch.m[5]; }, set _y(v){ ch.m = ch.m.slice(); ch.m[5] = v; ch.scripted = true; },
    get tint(){ return ch.tint; }, set tint(v){ ch.tint = v; },
  };
}

class Clip {
  constructor(id, name, parent, entry){
    this.id = id;
    this.def = S.sprites[id];
    this.name = name;
    this.parent = parent;
    this.entry = entry;             // the parent's display-list entry (transform, alpha, visibility)
    this.children = new Map();      // depth -> entry
    this.frame = 0;
    this.playing = true;
    this.vars = {};                 // per-clip AS variables (e.g. runnerNumber)
    this.fresh = true;              // created this tick: show frame 1, advance next tick
    this._goto(1);
    this._runActions(1);
  }

  // ---- timeline ----
  get totalFrames(){ return this.def.n; }
  _frameOf(f){
    if(typeof f === 'number') return Math.max(1, Math.min(this.def.n, f));
    // AS2 frame labels are case-insensitive (the game calls "pickLEFT" for "pickLeft")
    if(!this.def._lc){ this.def._lc = {}; for(const k in this.def.labels) this.def._lc[k.toLowerCase()] = this.def.labels[k]; }
    const n = this.def._lc[String(f).toLowerCase()];
    if(!n){ console.warn(`sprite ${this.id}: no label "${f}"`); return this.frame || 1; }
    return n;
  }
  // Step one frame forward (the normal playing case).
  _apply(f){
    for(const op of this.def.frames[f-1] || []){
      if(op.rm){ this.children.delete(op.d); continue; }
      let ch = this.children.get(op.d);
      if(!op.move || !ch){
        if(op.c == null) continue;
        ch = this._newEntry(op, f);
        this.children.set(op.d, ch);
      } else {
        if(op.c != null && op.c !== ch.c){
          ch.c = op.c; ch.placedAt = f;
          ch.inst = S.sprites[op.c] ? new Clip(op.c, ch.name, this, ch) : null;
        }
        if(!ch.scripted){ if(op.m) ch.m = op.m; if(op.a) ch.a = op.a; }
        if(op.name) ch.name = op.name, ch.inst && (ch.inst.name = op.name);
      }
    }
  }
  _newEntry(op, placedAt){
    const ch = { c: op.c, m: op.m || IDENTITY, a: op.a || null, name: op.name || null,
                 clip: op.clip || 0, scripted: false, inst: null, placedAt };
    if(S.sprites[op.c]) ch.inst = new Clip(op.c, ch.name, this, ch);
    return ch;
  }
  _goto(f){
    if(f === this.frame) return;
    this._sounds(f);
    if(f === this.frame + 1){ this._apply(f); this.frame = f; return; }
    // A jump: work out the display list at frame f without instantiating anything,
    // then keep each existing object that is the same placement (same depth,
    // character and placing frame) and create only the new ones. Flash never
    // constructs clips that live only on frames a goto skips over, so their
    // frame-1 scripts must not run.
    const desc = new Map();
    for(let k = 1; k <= f; k++){
      for(const op of this.def.frames[k-1] || []){
        if(op.rm){ desc.delete(op.d); continue; }
        const d = desc.get(op.d);
        if(!op.move || !d){
          if(op.c == null) continue;
          desc.set(op.d, { c: op.c, m: op.m || IDENTITY, a: op.a || null, name: op.name || null, clip: op.clip || 0, placedAt: k });
        } else {
          if(op.c != null && op.c !== d.c){ d.c = op.c; d.placedAt = k; }
          if(op.m) d.m = op.m;
          if(op.a) d.a = op.a;
          if(op.name) d.name = op.name;
        }
      }
    }
    const old = this.children;
    this.children = new Map();
    for(const [depth, d] of desc){
      const prev = old.get(depth);
      if(prev && !prev.attached && prev.c === d.c && prev.placedAt === d.placedAt){
        if(!prev.scripted){ prev.m = d.m; prev.a = d.a; }
        prev.name = d.name || prev.name;
        this.children.set(depth, prev);
      } else {
        this.children.set(depth, this._newEntry(d, d.placedAt));
      }
    }
    // attached (scripted) clips survive timeline jumps
    for(const [depth, ch] of old) if(ch.attached) this.children.set(depth, ch);
    this.frame = f;
  }
  // StartSound tags fire when their frame is entered, by playing on or by a goto
  // (a goto skips the sounds of the frames in between)
  _sounds(f){
    const s = this.def.sounds && this.def.sounds[f];
    if(s && Player.onSound) for(const [id, gain] of s) Player.onSound(id, gain, this);
  }
  _runActions(f){
    const act = this.def.actions && this.def.actions[f];
    if(!act) return;
    if(act === 'hook'){
      const fn = hooks[`${this.id}:${f}`];
      if(fn) fn(this);
      else if(!warned.has(`${this.id}:${f}`)){ warned.add(`${this.id}:${f}`); console.warn(`unported frame script: sprite ${this.id} frame ${f}`); }
      return;
    }
    for(const [op, arg] of act){
      if(op === 'stop') this.stop();
      else if(op === 'play') this.play();
      else if(op === 'gotoAndStop') this.gotoAndStop(arg);
      else if(op === 'gotoAndPlay') this.gotoAndPlay(arg);
    }
  }
  gotoAndStop(f){ const t = this._frameOf(f); this.playing = false; if(t !== this.frame){ this._goto(t); this._runActions(t); } }
  gotoAndPlay(f){ const t = this._frameOf(f); this.playing = true; if(t !== this.frame){ this._goto(t); this._runActions(t); } this.fresh = true; }
  stop(){ this.playing = false; }
  play(){ this.playing = true; }

  // One SWF frame: advance this clip, then its children (in depth order).
  tick(){
    if(this.fresh) this.fresh = false;
    else if(this.playing && this.def.n > 1){       // a one-frame clip never re-enters its frame
      const next = this.frame >= this.def.n ? 1 : this.frame + 1;
      this._goto(next);
      this._runActions(next);
    }
    for(const d of [...this.children.keys()].sort((a, b) => a - b)){
      const ch = this.children.get(d);
      if(ch && ch.inst) ch.inst.tick();
    }
    if(this.onEnterFrame) this.onEnterFrame();
  }

  // ---- children ----
  // Named child: the MovieClip itself, or a small handle for a named button/shape
  // so scripts can still set _visible / _x / _y on it.
  get(name){
    for(const ch of this.children.values()) if(ch.name === name) return ch.inst || handle(ch);
    return null;
  }
  attachMovie(linkage, name, depth){
    // Flash keeps timeline objects at negative internal depths, so script depths
    // never collide with them and always draw above; mirror that with an offset.
    const id = S.exports[linkage];
    const ch = { c: id, m: IDENTITY, a: null, name, scripted: true, attached: true, inst: null };
    ch.inst = new Clip(id, name, this, ch);
    this.children.set(SCRIPT_DEPTH + depth, ch);
    return ch.inst;
  }
  removeChild(name){
    for(const [d, ch] of this.children) if(ch.name === name) this.children.delete(d);
  }

  // ---- AS2 properties (stored on the parent's entry) ----
  _e(){ return this.entry; }
  _set(fn){ const e = this.entry; e.m = e.m.slice(); e.scripted = true; fn(e.m); }
  get _x(){ return this.entry.m[4]; }       set _x(v){ this._set(m => m[4] = v); }
  get _y(){ return this.entry.m[5]; }       set _y(v){ this._set(m => m[5] = v); }
  get _xscale(){ const m = this.entry.m; return Math.sign(m[0] || 1) * Math.hypot(m[0], m[1]) * 100; }
  set _xscale(v){ this._set(m => { const s = Math.hypot(m[0], m[1]) || 1, k = Math.abs(v)/100/s * (Math.sign(v) * Math.sign(m[0] || 1) || 1); m[0] *= k; m[1] *= k; }); }
  get _yscale(){ const m = this.entry.m; return Math.sign(m[3] || 1) * Math.hypot(m[2], m[3]) * 100; }
  set _yscale(v){ this._set(m => { const s = Math.hypot(m[2], m[3]) || 1, k = Math.abs(v)/100/s * (Math.sign(v) * Math.sign(m[3] || 1) || 1); m[2] *= k; m[3] *= k; }); }
  get _alpha(){ return alphaOf(this.entry.a) * 100; }
  set _alpha(v){ this.entry.a = [v/100, 0]; this.entry.scripted = true; }
  get _visible(){ return this.entry.visible !== false; }
  set _visible(v){ this.entry.visible = !!v; }
  // colorTransform.rgb as a 0xRRGGBB number; null / undefined leaves the clip as authored
  get tint(){ return this.entry.tint; }
  set tint(v){ this.entry.tint = v; }
}

// ---- rendering ----
const buttonHits = [];      // rebuilt every draw: {x0,y0,x1,y1, id, owner}
let hoverPoint = null;

function drawClip(ctx, clip, M, alpha, level = 0){
  const depths = [...clip.children.keys()].sort((a, b) => a - b);
  for(let i = 0; i < depths.length; i++){
    const ch = clip.children.get(depths[i]);
    if(ch.clip){                       // mask layer: clips depths (d, clipDepth]
      const masked = [];
      while(i + 1 < depths.length && depths[i + 1] <= ch.clip) masked.push(clip.children.get(depths[++i]));
      drawMasked(ctx, clip, ch, masked, M, alpha, level);
      continue;
    }
    drawEntry(ctx, clip, ch, M, alpha, level);
  }
}

function drawEntry(ctx, clip, ch, M, alpha, level){
  if(ch.visible === false) return;
  if(ch.tint != null){ drawTinted(ctx, clip, ch, M, alpha, level); return; }
  const m = mul(M, ch.m), a = alpha * alphaOf(ch.a);
  if(a <= 0) return;
  if(ch.inst){ drawClip(ctx, ch.inst, m, a, level); return; }
  const id = ch.c;
  if(S.shapes[id]){
    const img = images[id];
    if(!img || !img.complete || !img.naturalWidth) return;
    const o = S.shapes[id];
    ctx.setTransform(m[0], m[1], m[2], m[3], m[4], m[5]);
    ctx.globalAlpha = a;
    ctx.drawImage(img, o[0], o[1]);
  } else if(S.buttons[id]){
    drawButton(ctx, id, m, a, clip);
  } else if(S.texts[id]){
    drawText(ctx, S.texts[id], m, a, clip);
  }
}

// Offscreen canvases per mask nesting level: [layer, mask]
const maskPool = [];
function maskCanvases(level, w, h){
  let pair = maskPool[level];
  if(!pair){
    pair = maskPool[level] = [document.createElement('canvas'), document.createElement('canvas')];
  }
  for(const c of pair) if(c.width !== w || c.height !== h){ c.width = w; c.height = h; }
  return pair;
}

function drawMasked(ctx, clip, maskCh, masked, M, alpha, level){
  if(!masked.length) return;
  const { width: w, height: h } = ctx.canvas;
  const [layer, mask] = maskCanvases(level, w, h);
  const lc = layer.getContext('2d'), mc = mask.getContext('2d');
  lc.setTransform(1, 0, 0, 1, 0, 0); lc.globalAlpha = 1; lc.globalCompositeOperation = 'source-over'; lc.clearRect(0, 0, w, h);
  mc.setTransform(1, 0, 0, 1, 0, 0); mc.globalAlpha = 1; mc.globalCompositeOperation = 'source-over'; mc.clearRect(0, 0, w, h);
  for(const ch of masked) drawEntry(lc, clip, ch, M, alpha, level + 1);
  // a mask's fill counts in full whatever its colour or alpha; its own visibility does not matter
  drawEntry(mc, clip, Object.assign({}, maskCh, { visible: true, a: null }), M, 1, level + 1);
  lc.setTransform(1, 0, 0, 1, 0, 0); lc.globalAlpha = 1;
  lc.globalCompositeOperation = 'destination-in';
  lc.drawImage(mask, 0, 0);
  lc.globalCompositeOperation = 'source-over';
  ctx.save();
  ctx.setTransform(1, 0, 0, 1, 0, 0); ctx.globalAlpha = 1;
  ctx.drawImage(layer, 0, 0);
  ctx.restore();
}

const tintPool = [];
function drawTinted(ctx, clip, ch, M, alpha, level){
  const { width: w, height: h } = ctx.canvas;
  let c = tintPool[level];
  if(!c) c = tintPool[level] = document.createElement('canvas');
  if(c.width !== w || c.height !== h){ c.width = w; c.height = h; }
  const lc = c.getContext('2d');
  lc.setTransform(1, 0, 0, 1, 0, 0); lc.globalAlpha = 1; lc.globalCompositeOperation = 'source-over'; lc.clearRect(0, 0, w, h);
  drawEntry(lc, clip, Object.assign({}, ch, { tint: null }), M, alpha, level + 1);
  lc.setTransform(1, 0, 0, 1, 0, 0); lc.globalAlpha = 1;
  lc.globalCompositeOperation = 'source-in';
  lc.fillStyle = '#' + (ch.tint >>> 0).toString(16).padStart(6, '0').slice(-6);
  lc.fillRect(0, 0, w, h);
  lc.globalCompositeOperation = 'source-over';
  ctx.save();
  ctx.setTransform(1, 0, 0, 1, 0, 0); ctx.globalAlpha = 1;
  ctx.drawImage(c, 0, 0);
  ctx.restore();
}

function drawButton(ctx, id, m, a, owner){
  const b = S.buttons[id];
  if(!b.up && !b.over){                 // an invisible button: only its hit area
    if(!b.hit) return;
    const [x0, y0, x1, y1] = b.hit;
    const pts = [[x0, y0], [x1, y0], [x0, y1], [x1, y1]].map(([x, y]) => [m[0]*x + m[2]*y + m[4], m[1]*x + m[3]*y + m[5]]);
    buttonHits.push({ x0: Math.min(...pts.map(p => p[0])), y0: Math.min(...pts.map(p => p[1])),
                      x1: Math.max(...pts.map(p => p[0])), y1: Math.max(...pts.map(p => p[1])), id, owner });
    return;
  }
  const st = b.up ? 'up' : 'over';
  const o = b[st];
  const img = buttonImages[`${id}_${st}`];
  if(!img || !img.complete) return;
  // hit rect in device space: the drawn part of the state image. The exports (and the
  // SWF's own hit shapes, as bounds) can be far wider than the button — the menu's
  // are a whole row — so the transparent margin must not count.
  const [bx0, by0, bx1, by1] = (b.vis && b.vis[st]) || [0, 0, img.width, img.height];
  const pts = [[o[0] + bx0, o[1] + by0], [o[0] + bx1, o[1] + by0], [o[0] + bx0, o[1] + by1], [o[0] + bx1, o[1] + by1]]
    .map(([x, y]) => [m[0]*x + m[2]*y + m[4], m[1]*x + m[3]*y + m[5]]);
  const hit = { x0: Math.min(...pts.map(p => p[0])), y0: Math.min(...pts.map(p => p[1])),
                x1: Math.max(...pts.map(p => p[0])), y1: Math.max(...pts.map(p => p[1])), id, owner };
  buttonHits.push(hit);
  const over = hoverPoint && hoverPoint.x >= hit.x0 && hoverPoint.x <= hit.x1 && hoverPoint.y >= hit.y0 && hoverPoint.y <= hit.y1;
  const im = (over && buttonImages[`${id}_over`]) || img;
  const oo = (over && b.over) || o;
  ctx.setTransform(m[0], m[1], m[2], m[3], m[4], m[5]);
  ctx.globalAlpha = a;
  ctx.drawImage(im, oo[0], oo[1]);
}

const RASTER_PAD = 4;
function rasterText(t){
  const c = document.createElement('canvas');
  c.width = Math.ceil(t.b[2] + 2*RASTER_PAD); c.height = Math.ceil(t.b[3] + 2*RASTER_PAD + 4);
  drawText(c.getContext('2d'), Object.assign({}, t, { raster: false }), [1, 0, 0, 1, RASTER_PAD, RASTER_PAD], 1);
  return c;
}
function drawText(ctx, t, m, a, owner){
  ctx.globalAlpha = a;
  if(t.runs){
    const mm = mul(m, t.m);
    ctx.setTransform(mm[0], mm[1], mm[2], mm[3], mm[4], mm[5]);
    if(t.raster){                      // drawn once at 1 unit = 1 pixel and scaled like the exported button images
      if(!t._img) t._img = rasterText(t);
      ctx.imageSmoothingEnabled = true;
      ctx.drawImage(t._img, -RASTER_PAD, -RASTER_PAD);
      return;
    }
    ctx.textAlign = 'left'; ctx.textBaseline = 'alphabetic';
    for(const r of t.runs){
      ctx.font = `${r.size}px swf${r.font}`;
      if(r.stroke){                    // an outline under the whole run (the game's own labels bake one in)
        ctx.strokeStyle = r.stroke; ctx.lineWidth = r.strokeW; ctx.lineJoin = 'round';
        let x = r.x;
        for(let i = 0; i < r.s.length; i++){ ctx.strokeText(r.s[i], x, r.y); x += r.adv[i]; }
      }
      ctx.fillStyle = r.color;
      let x = r.x;
      for(let i = 0; i < r.s.length; i++){ ctx.fillText(r.s[i], x, r.y); x += r.adv[i]; }
      if(r.strokeOver){                // and a hairline of it over the fill, thinning the letters to match
        ctx.lineWidth = r.strokeOver; x = r.x;
        for(let i = 0; i < r.s.length; i++){ ctx.strokeText(r.s[i], x, r.y); x += r.adv[i]; }
      }
    }
    return;
  }
  const v = Player.resolveVar ? Player.resolveVar(t.var, owner) : undefined;
  const s = v == null ? (t.text || '') : String(v);
  ctx.setTransform(m[0], m[1], m[2], m[3], m[4], m[5]);
  ctx.font = `${t.size || 12}px swf${t.font}`;
  ctx.fillStyle = t.color || '#000';
  ctx.textBaseline = 'top';
  const [x0, y0, x1] = t.b;
  ctx.textAlign = t.align === 'center' ? 'center' : t.align === 'right' ? 'right' : 'left';
  const x = t.align === 'center' ? (x0 + x1) / 2 : t.align === 'right' ? x1 - 2 : x0 + 2;
  ctx.fillText(s, x, y0 + 2);
}

// ---- loading ----
function load(){
  const waits = [];
  for(const id of Object.keys(S.shapes)){
    const img = new Image();
    waits.push(new Promise(res => { img.onload = img.onerror = res; }));
    img.src = (S.inlineShapes && S.inlineShapes[id]) || `${BASE}shapes/${id}.svg`;
    images[id] = img;
  }
  for(const [id, st] of Object.entries(S.buttons)){
    for(const s of ['up', 'over', 'down'].filter(k => st[k])){
      const img = new Image();
      waits.push(new Promise(res => { img.onload = img.onerror = res; }));
      img.src = `${BASE}buttons/${id}_${s}.png`;
      buttonImages[`${id}_${s}`] = img;
    }
  }
  for(const [id, uri] of Object.entries(S.fonts || {})){
    const f = new FontFace(`swf${id}`, `url(${uri})`);
    waits.push(f.load().then(ff => document.fonts.add(ff), () => {}));
  }
  return Promise.all(waits);
}

const Player = {
  Clip, load,
  hook(id, frame, fn){ hooks[`${id}:${frame}`] = fn; },
  create(id, name){
    if(!S.sprites[id]){                        // a bare shape/text: wrap it in a one-frame clip
      const key = `wrap${id}`;
      S.sprites[key] = S.sprites[key] || { n: 1, labels: {}, frames: [[{ d: 1, c: id, move: 0 }]] };
      id = key;
    }
    return new Clip(id, name || null, null, { m: IDENTITY, a: null, scripted: true });
  },
  // Draw a root clip; call beginFrame() once per canvas frame before the first draw.
  beginFrame(){ buttonHits.length = 0; },
  draw(ctx, root, M){
    if(root.entry.visible === false) return;
    ctx.save();
    drawClip(ctx, root, mul(M, root.entry.m), alphaOf(root.entry.a));
    ctx.restore();
  },
  // Topmost button under a device-space point (buttons drawn later win).
  buttonAt(x, y){
    for(let i = buttonHits.length - 1; i >= 0; i--){
      const h = buttonHits[i];
      if(x >= h.x0 && x <= h.x1 && y >= h.y0 && y <= h.y1) return h;
    }
    return null;
  },
  setHover(p){ hoverPoint = p; },
  resolveVar: null,
  onSound: null,              // fn(soundId, gain, clip)
  mul,
};
window.SWFPlayer = Player;
})();
