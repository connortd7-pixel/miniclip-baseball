# Miniclip Baseball — Sprite Catalog

Cross-referenced against `DefineSprite_1686.as` (Bottom of the Ninth) and `DefineSprite_1844.as` (Arcade).  
Confidence: ✅ Confirmed by source | 🟡 Inferred from file count / proximity | ⬜ Unknown

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

## Sprite ID catalog

### ✅ Confirmed

| ID | Files | Identity |
|---|---|---|
| `DefineSprite_1539_runner` | 924 | **Runner** — all baserunner animations (explicitly named in export) |
| `DefineSprite_1686` | 1 | **Bottom of the Ninth** — game script container (no visual frames) |
| `DefineSprite_1844` | 1 | **Arcade Mode** — game script container (no visual frames) |

---

### 🟡 High-confidence inferences

**Large composite characters** — 3 sprites near 2000 frames each are almost certainly full batter/pitcher character trees with all sub-animations flattened by JPEXS:

| ID | Files | Likely identity |
|---|---|---|
| `DefineSprite_188` | 2014 | Batter (team A) — full animation tree |
| `DefineSprite_1988` | 2008 | Batter (team B) — full animation tree |
| `DefineSprite_2026` | 1972 | Batter (team C) or pitcher — full animation tree |
| `DefineSprite_2000` | 1371 | Batter or pitcher composite |
| `DefineSprite_192` | 890 | Character sub-component (body or arms) |
| `DefineSprite_1600` | 521 | Character sub-component |

**Outfield fielders** — four sprites each with exactly 69 frames match the fielder animation state count (8 directional walk states + pick-up/throw poses):

| ID | Files | Likely identity |
|---|---|---|
| `DefineSprite_1638` | 69 | Outfield fielder (fielder1 or 2) |
| `DefineSprite_1640` | 69 | Outfield fielder (fielder2 or 3) |
| `DefineSprite_1642` | 69 | Outfield fielder (fielder3 or 4) |
| `DefineSprite_1918` | 69 | Outfield fielder (fielder4 or 5) |

**Similar-count groups** — these clusters likely represent the same character type repeated across teams or roles:

| IDs | Files each | Likely identity |
|---|---|---|
| `731`, `757`, `783`, `941` | 44 | Fielder or runner component (4 variants) |
| `300`, `328`, `342`, `389` | 32 | UI element or base indicator (4 variants) |
| `1082` | 206 | Ball spinning animation (pitch) |
| `1113` | 291 | Pitcher wind-up + pitch animation |
| `1407` | 162 | Batter swing (hitHigh/hitMed/hitLow + idle) |
| `1475` | 421 | Large character composite (pitcher or batter body) |
| `1629` | 208 | Character animation (outfielder or runner) |

**Near the game scripts** — sprites immediately before 1686 are placed on stage by that script:

| ID | Files | Likely identity |
|---|---|---|
| `DefineSprite_1685` | 13 | Strike zone or small UI element |
| `DefineSprite_1683` | 13 | Hit area boundary (easy/med/hard variants nearby) |
| `DefineSprite_1687` | 3 | Transitions container (`matchWon`, `matchLost`, `inningsTied`) |
| `DefineSprite_1679` | 6 | Aim circle or marker |
| `DefineSprite_1619` | 48 | Scoreboard animation |
| `DefineSprite_1727` | 209 | Field view composite |
| `DefineSprite_1757` | 225 | Field view composite |

**Sounds** — 43 sound files in the `sounds/` folder, matching the audio bindings in the script:
`batSwing_fast`, `batHit_good`, `batHit_medium`, `batHit_mediumPoor`, `batHit_poorly`, `ballCatch_1`, `ballCatch_3`, `baseball_organ_FX`, `baseball_organ_tense_FX`, `crowd_bigClap`, `crowd_smallCheer`, `crowd_smallClap`, `crowd_unhappy`, `umpire_out_1`, `umpire_out_2`, `umpire_safe`, `umpire_Strike_grunt`, `umpire_yourOuttaHere_1/2/3`

---

### ⬜ Unknown / needs visual inspection

Everything with 1 file is likely a static shape, marker, or single-frame UI element. Not needed until later sprints.

---

## Priority for Sprint 1

| Asset needed | Best candidate | Action |
|---|---|---|
| Ball (pitch) | `DefineSprite_1082` | Open in file explorer, check frames |
| Pitcher wind-up | `DefineSprite_1113` | Open, look for pitch motion |
| Batter swing | `DefineSprite_1407` | Open, look for hitHigh/hitMed/hitLow |
| Aim circle | `DefineSprite_1679` | Open, likely a ring shape |

---

*Last updated: 2026-06-11 — inferences only, not visually verified*
