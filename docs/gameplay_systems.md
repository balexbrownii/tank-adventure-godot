# Tank's Great Adventure - Gameplay Systems

## THE SIGNATURE HOOK: "Repair the Story While Playing It"

The game is a storybook that is actively falling apart. This is the differentiator.

### Core Mechanic
- **Missing words become inventory:** Nouns/verbs drop out of sentences and become collectible items
- **Paste words back:** Insert words into sentences to unlock doors, calm NPCs, change destinations
- **Panel rearrangement:** Gorogoa-style frame manipulation changes geography
- **Narrator reacts:** The narrator protests, helps, or sabotages based on your tampering
- **Running out of paper:** Literal mechanic—pages tear, sentences shorten, the story degrades

### Implementation Examples
```gdscript
# Word drops out of sentence, becomes inventory item
# "Tank picked up the [HAMMER] and..."
# [HAMMER] falls out, becomes clickable inventory item
# Player must find where to paste it back

# Sentence with missing word blocks progress
# "The door was [_____] shut."
# Player pastes "LOCKED" → door becomes unlockable
# Player pastes "BARELY" → door can be pushed open
# Player pastes "EXPLOSIVELY" → door explodes

# Panel rearrangement
# Four story panels on screen
# Dragging Panel 3 next to Panel 1 connects their geography
# A door in Panel 1 now leads to the location in Panel 3
```

### Why This Works
Makes the presentation layer into gameplay—highly dynamic without requiring infinite content.

---

## The Approach Wheel: Brains / Brawn / Bizarre

Every major obstacle supports 2-3 solutions. This is the "versatile play styles" system inspired by Indiana Jones and the Fate of Atlantis.

| Approach | Character | Actions | Consequence Style |
|----------|-----------|---------|-------------------|
| **Brains** | Pig | Craft, bargain, sneak, misdirect | Clean, planned, lower Heat |
| **Brawn** | Tank | Smash, throw, intimidate, martial arts | Often causes new problems, raises Heat |
| **Bizarre** | Meta/Narrator/Luck | UI breaks, page tears, literal idioms, panel tricks | Unpredictable but internally logical |

### Why Three Approaches
- **More replayability** - Same puzzle, different content
- **Fewer stuck moments** - Always another angle
- **Stronger comedy** - Player chooses HOW to be ridiculous

---

## Core Innovation: Multi-Character Interaction Kits

Based on Day of the Tentacle's character-switching brilliance, each party member has a distinct interaction kit.

### Tank's Kit
| Action | Description | Use Case |
|--------|-------------|----------|
| **LIFT** | Pick up heavy objects (cars, boulders, people) | Brute force solutions |
| **SMASH** | Break things | Destructive shortcuts |
| **INTIMIDATE** | Scare NPCs with muscles | Get information, clear paths |
| **"CONFIDENTLY WRONG"** | Misinterpret situation heroically | Trigger chaos sequences |

### Pig's Kit
| Action | Description | Use Case |
|--------|-------------|----------|
| **TALK** | Negotiate, persuade, bargain | NPC interactions |
| **CRAFT** | Combine items, build things | Inventory puzzles |
| **PLAN** | Analyze situation, give hints | Player guidance |
| **SCHEME** | Set up distractions, traps | Indirect solutions |

### Mr. Snuggles' Kit
| Action | Description | Use Case |
|--------|-------------|----------|
| **REACH** | Access high/narrow places | Environmental traversal |
| **CARRY QUIETLY** | Move objects without alerting | Stealth puzzles |
| **SPRINT BURST** | Fast escape/chase sequences | Time-sensitive moments |
| **"LOOK INNOCENT"** | Distract guards, NPCs | Social stealth |

### Design Rule
Every puzzle should require **at least 2 kits** to solve, making it feel like teamwork rather than three reskins of the same character.

---

## The 3-Clue Rule

Every puzzle has exactly 3 clues spread across:

1. **Environment** - Visual clue in the background/scene
2. **Dialogue** - NPC or party member mentions it
3. **Inventory** - Item description contains hint

### Why This Matters
Tank is canonically "not that smart." The PLAYER must feel clever even when Tank isn't. The 3-clue system ensures:
- Solutions feel inevitable in hindsight ("Of course!")
- No pixel-hunting frustration
- Multiple entry points to the solution

### Example: "My Leg Is Gone" Puzzle

**Environment clue:** Leaf pile has leg-shaped bulge
**Dialogue clue:** Pig says "Somethin' ain't right about them leaves"
**Inventory clue:** Backpack description mentions "blanket you were sleeping under"

---

## Tank Vision vs Reality Vision

A signature mechanic: **4-panel puzzles** where Tank's perception must be aligned with reality.

### How It Works
1. Screen splits into 4 panels showing Tank's description
2. Player rearranges/rotates panels to match reality
3. When aligned, new hotspot appears (the "click" moment)

### Perfect For
- "Road is a long dark thick line with thin yellow lines..." → It's a highway
- Fog navigation sequences
- Any scene where Tank's misunderstanding IS the puzzle

### Implementation
```gdscript
# TankVisionPuzzle scene
# 4 draggable panels with Tank's labels
# Correct arrangement triggers reality_revealed signal
signal reality_revealed(hotspot_id: String)

func check_alignment() -> bool:
    # Compare panel positions to solution
    return panels_match_solution()
```

---

## Consequence Meters (Non-Fatal)

Choices bend scenes and dialogue, never cause dead ends.

### Heat Meter
- **What it tracks:** Wanted status (cops, soldiers, German commander)
- **How it rises:** Loud solutions, property damage, witnesses
- **How it affects gameplay:**
  - High heat = more guards in scenes
  - High heat = NPCs less willing to help
  - High heat = funnier "WANTED" poster variations

### Ignorance Meter
- **What it tracks:** How much Tank has learned about reality
- **How it changes:** Tank "learning the truth" makes some hazards REAL
- **Example:** If Tank learns cars aren't monsters, she can no longer LIFT them (loses that puzzle option)
- **Design tension:** Keeping Tank ignorant preserves more chaotic solutions

### Morale Meter
- **What it tracks:** Pig's patience, Deer's cooperation
- **How it drops:** Too many dumb choices, ignoring Pig's advice
- **How it affects gameplay:**
  - Low morale = fewer hints from Pig
  - Low morale = Mr. Snuggles less cooperative
  - Very low = funny "intervention" dialogue scene

### Critical Rule
**Meters NEVER cause game over.** They only change:
- Who trusts you
- What options unlock
- How hard the next puzzle is
- What dialogue you get

---

## Banter Trigger System

Every room has 3-5 optional interactables that exist purely for character chemistry.

### How It Works
- Click optional objects → triggers party banter
- Banter is funny, reveals character, sometimes hints at puzzles
- Triggering enough banter in a chapter unlocks rewards

### Rewards for Banter
- **Bonus hint tokens** - Extra Pig hints
- **Alternate joke solutions** - Funnier ways to solve puzzles
- **Case File annotations** - Pig's corrections to Tank's narrative

### Example Banter Triggers
```
[Night Camp - Optional Objects]
- Old tree stump → Tank: "A defeated enemy!" Pig: "That's a stump, partner."
- Moon → Tank: "The sun got hurt!" Mr. Snuggles: "..."
- Own shadow → Tank: "WHO'S THERE?!" Pig: *sighs*
```

---

## Case Files as Interactive Mechanic (Device 6 Style)

The "Case File" framing becomes gameplay, not just flavor.

### Text-as-Geography
- Player "scrolls" through case file pages
- Text becomes corridors, arrows, stamps, redactions
- Rotated text = rotated environment
- Clues hidden in typewriter alignment, timestamps, mislabeled locations

### Perfect For
- **Luggage tag puzzle** - Fold/rotate tag text to reveal destination
- **Navigation sequences** - Follow text "paths" through fog
- **Memory sequences** - Reconstruct what Tank "remembers" vs what happened

### "Fix the Record" Mini-Puzzles
- Player can correct Tank's case file entries
- Rewards for catching contradictions
- Meta-humor: narrator protests changes

---

## 3-Tier Hint System

Pig provides hints without breaking the eureka feeling.

### Tier 1: "What we should focus on"
```
Pig: "Reckon we oughta figure out how to get past them guards."
```
(Direction without solution)

### Tier 2: "Where to look"
```
Pig: "That there uniform rack might be useful, if you catch my drift."
```
(Location hint)

### Tier 3: "What to do"
```
Pig: "Take them clothes, put 'em on, walk right past. Simple as pie."
```
(Explicit solution)

### Hint Economy
- Tier 1: Always free
- Tier 2: Costs 1 hint token (earned via banter)
- Tier 3: Costs 2 hint tokens OR unlocks after 5 minutes stuck

---

## Puzzle Design Template

For every puzzle, document:

```
PUZZLE: [Name]
CHAPTER: [Number]
SOURCE BEAT: [Story reference]

SMART SOLUTION:
- Step 1: [action]
- Step 2: [action]
- Required kit(s): [Pig/Tank/Snuggles]

DUMB SOLUTION:
- Step 1: [action]
- Step 2: [action]
- Required kit(s): [Tank primarily]

3 CLUES:
1. Environment: [what player sees]
2. Dialogue: [what someone says]
3. Inventory: [item description hint]

CONSEQUENCES:
- Smart path: [meter changes, NPC reactions]
- Dumb path: [meter changes, NPC reactions]

BANTER TRIGGERS: [optional objects in scene]
```

---

## Example Puzzle Designs

### Puzzle 1: "My Leg Is Gone... It's a Miracle!"

**CHAPTER:** 2 (Ditch)
**SOURCE BEAT:** Tank thinks wolf bit off her leg, but it's under leaves.
**DESIGN GOAL:** Teach core interaction loop + establish Tank's unreliable reality.

**SOLUTIONS:**

| Character | Solution | Steps |
|-----------|----------|-------|
| Pig | Clean, fast | EXAMINE leaf pile → finds leg outline → PULL blanket |
| Mr. Snuggles | Hint-based | SNIFF → points to leaf pile → Tank clicks it |
| Tank | Funny fail-forward | SCREAM "MIRACLE" 3 times → vibration shakes leaves loose |

**3 CLUES:**
1. Environment: Leaf pile has suspicious leg-shaped bulge
2. Dialogue: Pig mutters "Somethin' ain't right about them leaves"
3. Inventory: Backpack mentions "your blanket's missing"

**TANK VISION ELEMENT:**
Leaf pile labeled "LEG VOID (WOLF DAMAGE)"
Reality: Just leaves over sleeping blanket

---

### Puzzle 2: "Road of Monsters" Escalation

**CHAPTER:** 3 (Highway)
**SOURCE BEAT:** Tank thinks cars are monsters, lifts them, chaos ensues.
**DESIGN GOAL:** Make chaos feel authored, not random.

**WIN CONDITION:** Redirect Tank's heroic impulse onto safe target (NOT "stop Tank")

**SMART SOLUTION:**
1. Notice inflatable promo monster outside gas station
2. Use Pig's TALK to challenge Tank: "That there's the boss monster!"
3. Tank attacks inflatable (harmless), cars ignored
4. Scene resolves with comedy

**DUMB SOLUTION (FAIL-FORWARD):**
1. Let Tank lift real car
2. No game over - short slapstick cut-in
3. Scene escalates to explosion → space sequence
4. Story continues (escalation-driven anyway)

**3 CLUES:**
1. Environment: Giant inflatable monster visible at gas station
2. Dialogue: Kid NPC says "That monster sign is so cool!"
3. Inventory: Pig's "PLAN" ability mentions "distraction targets"

**CONSEQUENCE:**
- Smart path: Heat stays low, Pig morale up
- Dumb path: Heat spikes, but unlocks "space sequence" content

---

### Puzzle 3: "Suitcase Tag to Texas" (Device 6 Style)

**CHAPTER:** 9 (Airport Luggage)
**SOURCE BEAT:** They crawl into suitcase tagged for Texas.
**DESIGN GOAL:** Make luggage sequence iconic and mechanically distinct.

**MECHANIC:** Text-as-geography puzzle

**SOLUTION:**
1. Luggage tag appears as interactive text
2. Player rotates/folds the tag text to align:
   ```
   DESTINATION:
        TEXAS
   [hidden airline code]
   ```
3. When aligned, barcode becomes readable
4. Unlocks "correct conveyor route"

**WHY IT WORKS:**
Turns "find right suitcase" into tactile, satisfying puzzle instead of random clicking.

---

## Tone Shift: The Crash

The cliffhanger crash into the Amazon is where comedy volume **temporarily drops** (not eliminates) to create contrast.

### Before Crash
- Full comedy, banter, absurdity
- Player comfortable with tone

### During/After Crash
- Quieter moments
- More atmospheric
- Pig genuinely worried
- Mr. Snuggles protective

### Why
That contrast makes the next big comedic release hit HARDER. Norco-style tonal depth without becoming grimdark.

---

## Recommended Vertical Slice

Build this sequence FIRST to test all systems:

**Road of Monsters → Gas Station → Space Re-Entry → Motorcycle Meets Pig+Deer**

### Why This Sequence
1. Showcases comedy puzzle logic
2. Tests cinematic escalation
3. Sets up party system introduction
4. Demonstrates "fail-forward" design
5. Uses multiple character kits
6. Has natural climax (space) and resolution (meeting companions)

### Features Tested
- [ ] Tank Vision vs Reality puzzles
- [ ] Multi-character switching (after companions join)
- [ ] Consequence meters (Heat from chaos)
- [ ] Banter triggers
- [ ] Fail-forward puzzle design
- [ ] Escalation pacing
- [ ] Hint system (Pig's first hints after joining)

---

## Puzzle Design Rules (EUREKA Ethos)

### No Pixel-Hunting
- Hotspot highlighting toggle available
- Objects "sparkle" only AFTER you've seen the clue that makes them relevant
- Every puzzle has an "aha," not a "guess"

### If the Solution is Dumb, the Foreshadowing Must Be Smart
- Comedy solutions need setup
- Player should laugh THEN go "yeah okay that tracks"

### Comedy is Reward, Not Punishment
Wrong actions trigger:
- A funny line
- A useful hint
- A world reaction
- **NEVER** "you die, reload"

### Optional Hinting as In-World System
- Narrator "accidentally" reveals margin notes
- Pig offers "plans"
- Deer offers... stares... that highlight what matters

---

## Commenter-Inspired Features

Based on GameSpot comment analysis—incorporating what fans love without bloating scope.

### Canada Conspiracy Board (Broken Sword energy)
- Recurring "conspiracy board" that grows each episode
- Globetrotting mystery feeling
- Visual thread connecting the journey

### One Puzzlebox Set-Piece (Machinarium/Myst/The Room)
- One location that's a dense mechanical contraption
- Candidates: dock machine, plane cargo latch system, rainforest wreckage "mechanical altar"
- Unusually strong musical identity for this section

### Interrogation Mechanic (Gabriel Knight/Sherlock)
- What you click on in the environment unlocks dialogue options
- Still funny, but adds investigation texture
- "Notice something weird" moments

### Found Footage Collectibles (Toonstruck/Starship Titanic)
- Optional cheesy videos Tank can find
- Tank misinterprets them hilariously
- Rewards exploration without blocking progress

### Tank's Thought Cabinet (Disco Elysium... but dumb)
- Intrusive thoughts pop up as clickable verbs
- Examples: "PUNCH LOGIC", "EAT EVIDENCE", "BEFRIEND DANGER"
- Optional silly interactions, never required

---

## Interaction Mode Rotation

The primary loop can't be identical every chapter:

| Mode | Description | Episodes |
|------|-------------|----------|
| **Classic Scene Puzzling** | Inventory + dialogue | 0, 2, 4 |
| **Panel Puzzles** | Rearrange story frames (Gorogoa) | 1, 3 |
| **Case File Puzzling** | Edit/repair narrator's record (Device 6) | 5, 7 |
| **Timed Choice Beats** | Rare panic comedy (Walking Dead) | 1, 8 |
| **Set-Piece Puzzles** | Environmental contraptions (Myst) | 3, 6 |

---

## The Investigation Loop

Borrowed from Sam & Max's "bizarre but logical" investigation vibe:

```
We need X → Who has X? → What do they want? → Puzzle chain → Got X!
```

Every episode should have at least one clear investigation loop the player can articulate.

---

## Storybook Framing Elements (King's Quest)

### Chapter Titles
Each episode opens with illustrated chapter card

### "Previously On..."
Recap with margin doodles showing key moments

### Collectible Margin Doodles
Hidden illustrations that flesh out the world

### Gentle Onboarding
Players aren't punished for not being genre veterans
