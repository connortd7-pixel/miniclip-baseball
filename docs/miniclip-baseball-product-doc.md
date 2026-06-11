# Miniclip Baseball — Agile / HCD Product Document

**Project:** Browser-based HTML5 recreation of Miniclip Baseball (Luke Whittaker, ~2004)  
**Approach:** Agile sprints with Human-Centered Design checkpoints  
**Stack:** HTML5 Canvas + vanilla JS (or Godot, if preferred)  
**Target platform:** Desktop browser (mouse input)

---

## Design Principles

These HCD principles govern every prioritization and implementation decision:

1. **The bat crack is the product.** The core hitting mechanic must feel satisfying before anything else is built on top of it. No feature earns its place until the swing feels good.
2. **Build vertically, not horizontally.** A fully working single at-bat is more valuable than a half-working full game. Each sprint should produce something playable.
3. **Prototype to learn, not to ship.** Early sprints are expected to change. Acceptance criteria exist to validate assumptions, not to lock in decisions.
4. **Scope is a feature.** Anything not on this list is out of scope until a deliberate decision adds it.

---

## Epics Overview

| # | Epic | Priority | Depends On |
|---|------|----------|------------|
| E1 | Core Batting Mechanic | Must Have | — |
| E2 | Ball Physics & Hit Outcomes | Must Have | E1 |
| E3 | Game State & Rules Engine | Must Have | E2 |
| E4 | Baserunning | Must Have | E2, E3 |
| E5 | Fielding AI | Must Have | E2, E4 |
| E6 | Bottom of the Ninth Mode | Must Have | E3, E4, E5 |
| E7 | Arcade Mode | Must Have | E3 |
| E8 | Audio & Game Feel | Should Have | E1 |
| E9 | Difficulty System | Should Have | E6, E7 |
| E10 | Menus & UI Shell | Should Have | E6, E7 |

---

## Epic 1 — Core Batting Mechanic

> **Goal:** A player can see a pitch, aim a cursor, and swing. The single most important thing to get right.

### User Stories

---

**E1-S1 — Pitch delivery**
> *As a player, I want to see the ball leave the pitcher's hand and travel toward the plate so that I have time to react and aim.*

**Acceptance Criteria:**
- Ball animates from pitcher position to home plate over a fixed duration
- Ball follows a visible arc (not teleportation)
- Pitch duration is consistent so timing is learnable
- There is a visible wind-up before the ball releases

**Definition of Done:** Pitch animation runs on loop; timing feels readable to a fresh player.

---

**E1-S2 — Aim cursor**
> *As a player, I want a circular cursor that I control with my mouse so that I can aim my swing at the incoming pitch.*

**Acceptance Criteria:**
- Cursor follows mouse position precisely within the hit zone
- Cursor is visually distinct (colored ring or reticle)
- Cursor is visible throughout the pitch delivery

**Definition of Done:** Cursor renders and tracks mouse with no perceptible lag.

---

**E1-S3 — Target marker**
> *As a player, I want a marker to appear showing where the ball will cross the plate so that I have something to aim at.*

**Acceptance Criteria:**
- Marker appears on or shortly after ball release (not before)
- Marker is visually different from the cursor (different color/shape)
- Marker position corresponds to where the ball actually passes

**Definition of Done:** A player who places their cursor on the marker and clicks makes contact.

---

**E1-S4 — Swing timing**
> *As a player, I want to click to swing so that I control when my bat meets the ball.*

**Acceptance Criteria:**
- Click registers a swing attempt
- There is a timing window: clicking too early or too late results in a miss or weak contact
- The sweet spot of the timing window is learnable through practice (not random)
- A missed swing is clearly communicated

**Definition of Done:** Consistent hits are achievable by a player who understands the mechanic. Misses feel fair, not arbitrary.

---

**E1-S5 — Contact detection**
> *As a player, I want my hit quality to reflect how close my cursor was to the marker so that skill is meaningfully rewarded.*

**Acceptance Criteria:**
- A hit is registered when cursor is within a defined radius of the marker at swing time
- Hit quality is calculated from cursor offset distance (center = best contact)
- Miss is registered outside that radius regardless of timing
- No "phantom hits" where the ball is clearly missed but contact registers

**Definition of Done:** Hit quality reliably produces better outcomes with better aim. Can be verified by logging offset vs. outcome.

---

### 🔍 HCD Checkpoint — After E1

**Playtest question:** Does the batting mechanic feel responsive and fair? Can a new player understand what to do within 3 pitches?

Gather informal feedback (self-play or one other person) before proceeding. The feel of the swing must be satisfying here — this is the entire game.

---

## Epic 2 — Ball Physics & Hit Outcomes

> **Goal:** Hits produce believable, varied outcomes based on cursor position and timing. The ball behaves like a baseball (enough).

### User Stories

---

**E2-S1 — Hit direction from cursor offset**
> *As a player, I want the ball's horizontal direction to be influenced by where my cursor is relative to the marker so that I can aim for gaps in the field.*

**Acceptance Criteria:**
- Cursor left of marker → ball goes left (pull side)
- Cursor right of marker → ball goes right (opposite field)
- Cursor on marker → ball goes up the middle
- Direction changes are gradual, not binary

---

**E2-S2 — Hit height from vertical cursor offset**
> *As a player, I want the ball's trajectory height to be influenced by vertical cursor position so that I can hit fly balls or ground balls intentionally.*

**Acceptance Criteria:**
- Cursor below marker → ball goes high (fly ball/home run zone)
- Cursor above marker → ball goes low (grounder)
- Cursor on marker → line drive
- Each trajectory type is visually distinct in the animation

---

**E2-S3 — Home run**
> *As a player, I want to sometimes hit the ball over the outfield wall so that there's a high-skill, high-reward outcome.*

**Acceptance Criteria:**
- Home run requires near-perfect cursor alignment + good timing
- Ball clears the outfield wall visually
- Home run is distinguished from a deep fly out
- All runners on base score on a home run

---

**E2-S4 — Miss and foul**
> *As a player, I want misses to register as strikes and poor contact to result in foul balls so that the game has consequences.*

**Acceptance Criteria:**
- Full miss = strike
- Extreme cursor offset = foul ball (no baserunner advancement)
- Strike count increments correctly
- Three strikes = strikeout (out recorded, at-bat ends)

---

**E2-S5 — Ball landing zone**
> *As a player, I want to see where the ball lands in the field so I can understand the outcome of my hit.*

**Acceptance Criteria:**
- Ball trajectory is animated through the air
- Landing position is visually communicated (dust puff, marker, etc.)
- Landing zone determines which fielder responds

---

## Epic 3 — Game State & Rules Engine

> **Goal:** The game tracks counts, outs, runs, and inning state correctly. Winning and losing conditions work.

### User Stories

---

**E3-S1 — Ball/strike count**
> *As a player, I want to see the current ball and strike count so that I understand the pitch situation.*

**Acceptance Criteria:**
- Count increments correctly (balls on non-swung balls outside zone, strikes on misses/swinging strikes/called strikes)
- 3 strikes = strikeout, out recorded
- 4 balls = walk, batter advances to first
- Count resets on a new at-bat

---

**E3-S2 — Out tracking**
> *As a player, I want outs tracked and displayed so I know how many chances I have left.*

**Acceptance Criteria:**
- Strikeout, flyout, groundout all increment out count
- 3 outs end the half inning
- Out indicators are clearly visible in UI

---

**E3-S3 — Run scoring**
> *As a player, I want runs to score and be tracked so I know my current total.*

**Acceptance Criteria:**
- Run scores when a runner crosses home plate
- Score display updates immediately
- Run total persists across at-bats within the inning

---

**E3-S4 — Win/loss/tie conditions**
> *As a player, I want the game to clearly end when I win, lose, or tie so that each session has a resolution.*

**Acceptance Criteria:**
- Win condition: defined per mode (see E6, E7)
- Loss condition: 3 outs with score more than 1 run short of target
- Tie condition: 3 outs with score exactly 1 run short of target → game enters sudden death (`scoreTarget` decrements by 1, play continues)
- Each state triggers a distinct result screen
- No ambiguous game states (game never hangs)

**Source note:** Confirmed in `DefineSprite_1686`. Three distinct branches: `matchWon`, `matchLost`, and `inningsTied`. On tie, `scoreTarget -= 1` before proceeding.

---

## Epic 4 — Baserunning

> **Goal:** Runners advance automatically and realistically. The bases feel alive.

### User Stories

---

**E4-S1 — Runner placement display**
> *As a player, I want to see which bases have runners so I can track scoring opportunities.*

**Acceptance Criteria:**
- First, second, and third base indicators show occupied/empty state
- Display updates in real time as runners advance
- Visual is clear at a glance (filled vs. unfilled base icon)

---

**E4-S2 — Automatic advancement on hits**
> *As a player, I want runners to advance the appropriate number of bases on my hits so I don't have to manage them manually.*

**Acceptance Criteria:**
- Single: lead runner(s) advance 1–2 bases depending on hit quality/position
- Double: all runners advance 2 bases
- Triple: all runners advance 3 bases (or score from 1st)
- Home run: all runners score

---

**E4-S3 — Scoring from base**
> *As a player, I want runners to score when they reach home plate so runs are counted.*

**Acceptance Criteria:**
- Runner disappears from base display when they score
- Run counter increments
- Scoring animation or visual feedback is shown

---

**E4-S4 — Force outs**
> *As a player, I want fielders to be able to throw out runners on force plays so that grounders are not automatically safe.*

**Acceptance Criteria:**
- On a grounder, fielder can throw to first (or another forced base)
- Out is recorded if throw beats runner
- Close plays have a threshold window (not always safe, not always out)

---

**E4-S5 — Walk advancement**
> *As a player, I want runners to advance on a walk when forced so the rules are accurate.*

**Acceptance Criteria:**
- Walk with runner on first: runner advances to second
- Bases loaded walk: all runners advance, run scores
- Batter takes first base

---

## Epic 5 — Fielding AI

> **Goal:** Fielders react to the ball, giving the player meaningful outs to worry about.

### User Stories

---

**E5-S1 — Fielder positioning**
> *As a player, I want to see fielders positioned in the field so the game looks like baseball.*

**Acceptance Criteria:**
- At minimum: left fielder, center fielder, right fielder, first baseman visible
- Fielders are at plausible positions before each pitch
- Fielder sprites/shapes are distinguishable from the field

---

**E5-S2 — Fielder chase**
> *As a player, I want fielders to run toward where the ball lands so there's a chase element.*

**Acceptance Criteria:**
- Nearest fielder moves toward ball landing zone
- Fielder reaches the ball after a delay based on distance
- Fielder visually "picks up" the ball

---

**E5-S3 — Throw to base**
> *As a player, I want fielders to throw to the appropriate base so force outs and tag plays can happen.*

**Acceptance Criteria:**
- Fielder throws to first on grounders (unless a better play is available)
- Throw is animated (arc or line to base)
- Throw time is based on distance from fielder to base
- Throw can beat a runner or not — both outcomes are possible

---

**E5-S4 — Fly ball catch**
> *As a player, I want fielders to catch fly balls that don't reach the wall so I can be retired on pop-ups and deep flies.*

**Acceptance Criteria:**
- Fly ball within fielder range results in a catch = out
- Catch is visually communicated
- Ball beyond fielder range falls in for a hit
- Home run zone is outside all fielder ranges

---

## Epic 6 — Bottom of the Ninth Mode

> **Goal:** The signature mode. Player is down runs with 3 outs to mount a comeback.

### User Stories

---

**E6-S1 — Deficit setup**
> *As a player, I want to start the mode already down by runs so there's immediate tension.*

**Acceptance Criteria:**
- Opponent score is pre-set on game start
- Player score starts at 0
- Deficit is shown clearly before first pitch ("You need X runs to win")

---

**E6-S2 — Comeback win condition**
> *As a player, I want to win when I outscore the opponent before 3 outs so that comebacks are possible and satisfying.*

**Acceptance Criteria:**
- Win triggers immediately when player score exceeds opponent score
- Win screen celebrates the comeback
- Game does not continue after win condition is met

---

**E6-S3 — Loss condition**
> *As a player, I want to lose when I make 3 outs without overcoming the deficit so failure has finality.*

**Acceptance Criteria:**
- 3 outs triggers loss state
- Loss screen shows final score and deficit
- Loss is communicated without being demoralizing (prompt to retry)

---

**E6-S4 — Full inning structure**
> *As a player, I want to face a real lineup of at-bats within the inning so the mode feels like a proper game situation.*

**Acceptance Criteria:**
- At-bats continue until 3 outs
- Baserunner state persists correctly across at-bats
- Batting order can be simple (batter resets each at-bat; no multi-player lineup required for v1)

---

## Epic 7 — Arcade Mode

> **Goal:** A score-chasing mode. 10 pitches, hit a target in the field for points.

### User Stories

---

**E7-S1 — Target display**
> *As a player, I want to see a target appear in the outfield before each pitch so I know where to aim.*

**Acceptance Criteria:**
- Concentric ring target appears at a field position before each pitch
- Target position varies pitch-to-pitch
- Target is visible throughout the pitch

---

**E7-S2 — Proximity scoring**
> *As a player, I want to score more points for landing the ball closer to the target center so precision is rewarded.*

**Acceptance Criteria:**
- There are **4 rings**, not 3 — inner to outer: ring 4, ring 3, ring 2, ring 1
- Score breakdown is shown after each hit
- Point values are communicated visually (ring labels or post-hit display)
- Miss (outside all rings) = 0 points

**Source note:** Confirmed in `DefineSprite_1844`. Four distance thresholds: ≤10 (ring 4), ≤42 (ring 3), ≤62 (ring 2), ≤85 (ring 1). The original highlights the ring at first bounce, not at landing.

---

**E7-S3 — Bounce bonus**
> *As a player, I want the first bounce to score double points so there's a reason to avoid fly balls in this mode.*

**Acceptance Criteria:**
- First bounce landing in/near target zone scores 2× that ring's value
- Fly ball (no bounce) scores normal value
- Bonus is visually called out ("BOUNCE x2!")

---

**E7-S4 — 10-pitch limit**
> *As a player, I want exactly 10 pitches per session so the mode is time-bounded and replayable.*

**Acceptance Criteria:**
- Pitch counter displays remaining pitches
- Session ends after 10th pitch resolves
- Strikes/fouls count against the 10 pitches

---

**E7-S5 — Final score display**
> *As a player, I want to see my total score at the end so I have a number to try to beat.*

**Acceptance Criteria:**
- Running total is shown during play
- Final total is displayed prominently on game end
- Option to play again is immediately available

---

## Epic 8 — Audio & Game Feel

> **Goal:** The game sounds and feels like baseball. Juice makes good mechanics feel great.

### User Stories

---

**E8-S1 — Bat crack**
> *As a player, I want a satisfying crack sound on contact so hitting feels physical and rewarding.*

**Acceptance Criteria:**
- Sound fires on every contact event
- Sound varies slightly with hit quality (solid contact vs. weak contact)
- No sound on a swing-and-miss (or a distinct "whoosh")

---

**E8-S2 — Crowd noise**
> *As a player, I want crowd noise that reacts to what happens so the game feels alive.*

**Acceptance Criteria:**
- Crowd reacts to hits (cheer volume scales with hit quality)
- Home run triggers a big crowd reaction
- Strikeout / out triggers a groan or subdued crowd
- Ambient crowd hum plays between pitches

---

**E8-S3 — Hit feedback**
> *As a player, I want visual feedback on contact so I know the quality of my hit at a glance.*

**Acceptance Criteria:**
- Color or text flash indicates hit quality ("PERFECT", "GOOD", "WEAK")
- Feedback disappears quickly (< 1 second)
- Feedback does not obscure important game information

---

**E8-S4 — Big hit feel**
> *As a player, I want home runs and great hits to feel special so there's a peak emotional moment.*

**Acceptance Criteria:**
- Home run has a distinct visual treatment (camera, flash, crowd surge)
- Big hit feel is meaningfully different from a regular single
- Does not feel overproduced — restrained but satisfying

---

### 🔍 HCD Checkpoint — After E8

**Playtest question:** Does a complete session feel satisfying start to finish? Is there a moment of genuine excitement? Is the loss state frustrating in a motivating way or just frustrating?

---

## Epic 9 — Difficulty System

> **Goal:** The game scales to player skill. Beginners can learn; experienced players are challenged.

### User Stories

---

**E9-S1 — Difficulty selection**
> *As a player, I want to choose Easy, Medium, or Hard before starting so I can match the game to my skill.*

**Acceptance Criteria:**
- Difficulty selection appears before mode selection or after
- Selection is remembered for the session
- Default is Easy for first-time players

---

**E9-S2 — Pitch speed scaling**
> *As a player, I want pitches to be faster on harder difficulties so that timing becomes more challenging.*

**Acceptance Criteria:**
- Easy: slower pitch speed, longer reaction window
- Medium: moderate speed
- Hard: fast pitches with a noticeably shorter window

---

**E9-S3 — Strike zone indicator**
> *As a player, I want the strike zone to be visible on Easy so I can learn what a ball vs. strike is.*

**Acceptance Criteria:**
- Easy: strike zone box displayed during pitch
- Medium/Hard: no strike zone indicator
- Absence on harder difficulties is intentional, not a bug — not communicated as "hidden" but as expected knowledge

---

**E9-S4 — Deficit scaling (Bottom of the Ninth)**
> *As a player, I want the run deficit to increase with difficulty so the mode's challenge scales.*

**Acceptance Criteria:**
- Easy: down 2 runs
- Medium: down 4 runs
- Hard: down 8 runs

---

## Epic 10 — Menus & UI Shell

> **Goal:** The game has a front door and a back door. Players can navigate and restart without friction.

### User Stories

---

**E10-S1 — Main menu**
> *As a player, I want a main menu where I can choose my mode so the game has a clear starting point.*

**Acceptance Criteria:**
- Menu presents "Bottom of the Ninth" and "Arcade" as options
- "High Scores" is present (can be a stub in v1)
- Visual design evokes the original (baseball aesthetic)

---

**E10-S2 — In-game scoreboard**
> *As a player, I want a persistent score/count display during play so I never have to guess the game state.*

**Acceptance Criteria:**
- Runs scored, outs, balls/strikes always visible
- Pitch count visible in Arcade mode
- Display is readable without hovering or clicking

---

**E10-S3 — Game over / result screen**
> *As a player, I want a clear result screen after each session so I have closure and can act immediately.*

**Acceptance Criteria:**
- Shows win or loss state unambiguously
- Shows final score / run total
- "Play Again" and "Main Menu" options both present
- No dead ends (player is never stuck)

---

**E10-S4 — High scores (Arcade)**
> *As a player, I want my high score saved locally so I have a personal record to beat.*

**Acceptance Criteria:**
- Best Arcade score persisted in localStorage
- High score shown on result screen and main menu
- Does not require login or account

---

## Recommended Sprint Sequence

| Sprint | Epics / Stories | Deliverable |
|--------|----------------|-------------|
| 1 | E1 (all) | Playable batting prototype — pitch, aim, swing, contact detection |
| 2 | E2 (all) | Hits go somewhere believably; misses register as strikes |
| — | **HCD Checkpoint 1** | Does the bat crack make you want to hit again? |
| 3 | E3 + E4 | Full at-bat with count, outs, baserunners — single inning works |
| 4 | E5 | Fielders chase, throw, record outs |
| — | **HCD Checkpoint 2** | Does a full inning feel like baseball? Are force outs satisfying? |
| 5 | E6 | Bottom of the Ninth mode fully playable end-to-end |
| 6 | E7 | Arcade mode fully playable end-to-end |
| — | **HCD Checkpoint 3** | Is there a mode you'd rather play twice in a row? Why? |
| 7 | E8 | Audio + hit feedback — run full sessions with and without sound |
| 8 | E9 | Difficulty selection wired to all systems |
| 9 | E10 | Menus, scoreboard, result screen, high score |
| — | **HCD Checkpoint 4** | Can someone pick this up cold and play a full game without confusion? |

---

## Out of Scope (v1)

The following are explicitly deferred to avoid scope creep:

- Pitching control — **confirmed absent in the original**. The player never pitches; the AI pitcher is fully automatic. This is intentional, not an omission.
- Full 9-inning game mode
- Multiplayer
- Mobile / touch support
- Custom player/team names
- Unlockables or progression systems
- Leaderboards (network)
- Sound settings / volume control
- Localization

These can be revisited after v1 ships and is playtested.

---

*Document version 1.1 — updated after SWF decompilation*

---

## Technical Reference

This section is a pointer to source material, not implementation guidance. Acceptance criteria are intentionally written without implementation detail — refer here when you need to know exactly how the original behaved.

**Source files (decompiled from `miniclip-baseball.swf` via JPEXS):**

`DefineSprite_1686/frame_1/DoAction.as` — **Bottom of the Ninth mode logic.** Contains: aim circle lerp, pitch pre-simulation and playback, hit detection, foul detection, baserunner advancement, fielder AI, throw logic, run/out/win/loss/tie state machine, and all sound bindings.

`DefineSprite_1844/frame_1/DoAction.as` — **Arcade mode logic.** Structurally identical to 1686 for the batting mechanic; differs in: 4-ring scoring system, `balls_left` counter replacing inning state, no baserunners, home run handling simplified.

**Key behaviours confirmed by source:**
- The aim circle does not directly track the mouse. It lerps toward it by `1/mouseDifficulty` per frame (Easy: 5, Med: 10, Hard: 20 at original 24fps).
- The pitch is pre-simulated frame-by-frame before the pitcher animates, then played back from a recorded array. The `ballPassesBat_marker` position is set during this pre-sim.
- Hit direction: `aimArea._x = ballMarker._x + (fm + sm) * 3` where `fm` = cursor offset from ball, `sm` = ball offset from field centre.
- Hit height/arc: `upStrength = 25 + v/8 - power/3` where `v` = vertical cursor offset from marker.
- Home run fires when `hit_distance >= 820` AND `ball._y < -25` (ball still high at the wall).
- Arcade has 4 rings: ≤10, ≤42, ≤62, ≤85 (distance units).
- Three end states in Bottom of the Ninth: `matchWon`, `matchLost`, `inningsTied`. On tie, `scoreTarget -= 1` before re-entering play.
