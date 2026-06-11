# Miniclip Baseball — Sprite Catalog

Cross-referenced against `DefineSprite_1686.as` (Bottom of the Ninth) and `DefineSprite_1844.as` (Arcade).
Instance name → Sprite ID mappings confirmed by parsing `PlaceObject2` tags directly from `miniclip-baseball.swf`.

Confidence: ✅ Confirmed by SWF binary | 🟡 Inferred | ⬜ Unknown

---

## Named instances in game scripts

These are the movie clip names the game logic talks to directly. The sprite IDs that correspond to them are inferred below.

| Instance name | Role | Animation labels |
|---|---|---|
| `pitcher` | Pitcher figure | `pitch` |
| `hitter` | Batter figure | `hitHigh`, `hitMed`, `hitLow` |
| `ballAll` | Ball during pitch | spinning ball frames |
| `ballShadow` | Ball shadow during pitch | — |
| `ballFly` | Ball after contact (near view) | — |
| `field.ballFly` | Ball after contact (field view) | — |
| `aimCircle` | Player's aim cursor | — |
| `aimCircleShadow` | Aim cursor shadow | — |
| `strikeZone` | Strike zone box (easy only) | — |
| `field.fielder1–5` | Outfield fielders | `waiting`, `left`, `right`, `up`, `down`, `upLeft`, `upRight`, `downLeft`, `downRight`, `waitingToCatch`, `pickLEFT`, `pickRIGHT`, `pickUP`, `pickDown` |
| `field.fielder6–9` | Base fielders | `baseWaiting`, `throwLeft`, `throwRight`, `throwUp`, `throwDown` |
| `field.runnerHolder` | Container for runner instances | — |
| `runner` (attached dynamically) | Individual baserunner | `runToFirst`, `runToSecond`, `runToThird`, `runToFourth`, `waiting`, `empty`, `outWalk`, `outText` |
| `field.landMarker` | Arcade mode target rings | `ring1`–`ring4` sub-clips |
| `field.umpire1–3` | Base umpires | `out` |
| `scoreboard` | In-game scoreboard | `runsToGet`, `strike`, `noBall` |
| `transitions` | Full-screen transition overlays | `homeRun`, `foulHit` |
| `strikeAnim` | Strike counter display | `strike1`, `strike2`, `strike3` |
| `btn_nextBall` | Next pitch button | frame 1 (hidden), frame 2 (visible) |
| `acl` | Aim circle constraint boundary (invisible) | — |
| `test` | Invisible pre-sim container | — |

---

## ✅ Confirmed Sprite ID Catalog

All mappings confirmed by parsing PlaceObject2 tags in the SWF binary.

| Sprite ID | Files | Instance Name | Identity |
|---|---|---|---|
| `DefineSprite_688` | 138 | `pitcher` | Pitcher figure — wind-up + pitch animation |
| `DefineSprite_1082` | 206 | `hitter` | Batter — hitHigh / hitMed / hitLow + run to first |
| `DefineSprite_592` | 1 | `ballAll` | Ball during pitch — **vector shape, not raster sprite** |
| `DefineSprite_594` | 1 | `ballShadow` | Ball shadow during pitch — vector |
| `DefineSprite_599` | 1 | `ballPassesBat_marker` | Target crosshair marker — vector |
| `DefineSprite_690` | 6 | `aimCircle` | Player aim cursor |
| `DefineSprite_692` | 1 | `aimCircleShadow` | Aim cursor shadow |
| `DefineSprite_694` | 1 | `strikeZone` | Strike zone box (easy mode only) |
| `DefineSprite_696` | 1 | `acl` | Aim circle constraint boundary (invisible) |
| `DefineSprite_697` | 1 | `ballFly` | Ball in flight after contact — near/batting view |
| `DefineSprite_1547` | 1 | `ballFly` (field) | Ball in flight after contact — field/overview view |
| `DefineSprite_1407` | 162 | `fielder1–9` | ALL fielders — outfield + base (same sprite, 9 instances) |
| `DefineSprite_1440` | 99 | `umpire1–3` | Base umpires |
| `DefineSprite_1113` | 291 | `scoreboard` | In-game scoreboard animation |
| `DefineSprite_1114` | 1 | `base1–4` | Base indicators (same sprite, 4 instances) |
| `DefineSprite_1548` | 1 | `field` | Field container (Bottom of the Ninth) |
| `DefineSprite_1811` | 1 | `field` | Field container (Arcade mode) |
| `DefineSprite_1539_runner` | 924 | `runner` | All baserunner animations |
| `DefineSprite_1542` | 1 | `runnerHolder` | Container for dynamically attached runner instances |
| `DefineSprite_1794` | 1 | `landMarker` | Arcade mode target rings (ring1–ring4) |
| `DefineSprite_581` | 361 | `scoreboard` | Scoreboard — Bottom of the Ninth variant |
| `DefineSprite_626` | 10 | `runnerOnSecond` | Runner on second base indicator |
| `DefineSprite_600` | 1 | `test` | Invisible pre-sim ball container |
| `DefineSprite_1586` | 60 | `soundHolder` | Sound channel container |
| `DefineSprite_1588` | 63 | `fieldTimer` | Field animation timer (Bottom of the Ninth) |
| `DefineSprite_1813` | 41 | `fieldTimer` | Field animation timer (Arcade) |
| `DefineSprite_1590` | 45 | `foulWalkTimer` | Foul/walk animation timer |
| `DefineSprite_1620` | 2 | `btn_nextBall` | Next pitch button |
| `DefineSprite_1549` | 1 | `fielder_functionHolder` | Fielder logic container |
| `DefineSprite_2029` | 46 | `sound0–8`, `introMusic_loop` | Sound channel instances |

---

## Key corrections from earlier guesses

| Sprite ID | Earlier guess | Confirmed identity |
|---|---|---|
| `DefineSprite_1082` | Ball spinning animation | **Batter (hitter)** — user confirmed |
| `DefineSprite_1113` | Pitcher wind-up | **Scoreboard** |
| `DefineSprite_1407` | Batter swing | **All fielders** (fielder1–9, same sprite) |
| `DefineSprite_592` | Unknown | **Ball — vector shape, 1 file, no raster sprite needed** |

---

## Sprint 1 asset priority

| Asset | Sprite ID | Files | Status |
|---|---|---|---|
| Pitcher | `DefineSprite_688` | 138 | ✅ ID confirmed — copy frames to `src/assets/sprites/pitcher/` |
| Batter | `DefineSprite_1082` | 206 | ✅ ID confirmed — copy frames to `src/assets/sprites/hitter/` |
| Ball | `DefineSprite_592` | 1 | ✅ Vector shape — **keep canvas arc, no sprite needed** |
| Aim circle | `DefineSprite_690` | 6 | ✅ ID confirmed — small, check frames |
| Background | `images/500.jpg` | — | ✅ Located — copy to `src/assets/images/bg-batting.jpg` |

---

*Last updated: 2026-06-11 — all instance name → ID mappings confirmed from SWF binary*
