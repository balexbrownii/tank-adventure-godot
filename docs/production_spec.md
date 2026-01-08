# Tank's Great Adventure - Production Spec

## Global Production Conventions

### Core UI Rules

#### Vision Toggle
- **Tank Vision:** Humorous mislabels, unlocks "confidently wrong" interactions
- **Reality Vision:** Accurate labels, reveals mechanics/clues
- **Optional action:** "Tell Tank" (turns a Reality clue into Tank knowledge)

#### Meters
| Meter | Description |
|-------|-------------|
| **Heat** | How "wanted" you are (police/soldiers attention) |
| **Ignorance** | How much Tank understands reality (low = dumb luck powers) |
| **Morale** | Pig patience + Deer calm (affects hint tone and some options) |

#### Fail-Forward Standard
No hard fail states. "Failures" result in:
- A short comedic setback
- An item swap
- A meter change
- A different entry point into the next room

#### Hint System
The hint button is framed as: **Pig's Margin Notes** (even before Pig joins).

Each room has 3 tiers:
1. **Nudge** (what to focus on)
2. **Direction** (where/how)
3. **Near-solution** (explicit step)

---

## ROOM 01 — Wanted Camp (Night)

**Story beat:** Wanted poster, camping, German soldiers show up, bacon sandwich incident.

**Playable:** Tank
**Goal:** Leave camp alive with at least one useful item (Backpack OR Vine) and avoid unnecessary Heat.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Wanted poster | MEGA PRIZE PAPER | "Wow. That's… a lot of dollar signs. I must be famous." | WANTED POSTER | "Tank is wanted in multiple countries. Reward is absurd." | Tells player "Heat exists." |
| Campfire | WARM ORANGE FRIEND | "Hello, fire. Please don't bite me." | CAMPFIRE | "A small fire. Good for light… bad for hiding." | |
| Bacon crumbs | BACON DUST | "Emergency flavor stash." | BACON REMAINS | "Greasy crumbs. Strong smell. Useful bait." | Can be used as lure |
| Backpack | LOOT BAG | "This is my treasure sack. It's… kinda gross." | STOLEN BACKPACK | "A child's backpack. Dirty and overstuffed." | "Tell Tank" increases Ignorance |
| Vine coil | TRIP SNAKE | "Sneaky plant rope tried to murder me." | VINE | "Strong vine. Good for tying." | |
| River path | SOLDIER WATER | "This river solves problems." | RIVER | "Fast current. Loud. Hides footsteps." | |

### Obstacle: Patrol Arrives
**Trigger:** After 2–3 interactions, a lantern beam sweeps in.

### Solutions

| Approach | Method | Result | Meters |
|----------|--------|--------|--------|
| **BRAWN** | Click soldiers: Headlock → Kick → Chop → Throw | Escape guaranteed | Heat +1 |
| **BRAINS** | Use Bacon Remains on bushes → soldiers investigate → hide behind rocks → exit | Clean escape, no Poster Scrap | Heat +0 |
| **BIZARRE** | Tank Vision: "Offer Tribute" (throw crumbs into fire) | Soldiers argue about smell, clean exit | Heat +0, Ignorance +0 |

### Pig Hint Ladder
1. "Getting caught isn't deadly, but it'll get loud. Stay out of the lantern beam."
2. "That bacon smell is a tool. Use it on something the soldiers will check."
3. "Drop the crumbs in the bushes, then hide behind the rocks until they pass."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Ignorance | Flags |
|------|--------------|------------|------|-----------|-------|
| Brawn | Backpack, Vine (optional) | None | +1 | 0 | SOLDIERS_DEFEATED |
| Stealth | Backpack, Vine, Bacon (spent) | Poster Scrap | 0 | 0 | SOLDIERS_EVADED |
| Tribute | Backpack, Poster Scrap | Bacon (spent) | 0 | 0 | SOLDIERS_CONFUSED |

---

## ROOM 02 — Werewolf Trail (Chase)

**Story beat:** Werewolf appears, wants bacon, Tank runs, trips on vine.

**Playable:** Tank
**Goal:** Reach the ditch. Optional: collect 1 bonus item.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Werewolf | ARCH NEMESIS | "Not you again! Stop being dramatic!" | WEREWOLF | "Fast. Too close. Do not 'fight'." | No fight win here |
| Hollow log | SAFETY TUBE | "A tunnel! Like in cartoons!" | HOLLOW LOG | "You can crawl through… if you don't get stuck." | |
| Thorn bush | SPIKE WALL | "Evil plant teeth." | THORNS | "Painful, but could snag fur." | Sets up decoy |
| Mud patch | SNEAK GOO | "Delicious dirt lotion." | MUD | "Slippery. Could ruin tracks." | |
| Ditch edge | GROUND MOUTH | "A hole that wants me." | DITCH | "Safe cover. Drop in." | Exit gate |

### Obstacle: Escape Sequence (rapid hotspot clicks)

### Solutions

| Approach | Method | Reward | Tradeoff |
|----------|--------|--------|----------|
| **Speed** | Click: Hollow Log → Mud → Ditch | Fastest, clean | Drop Bacon Remains |
| **Snag** | Click Thorn Bush → "Drag fur" prompt | Gain Thorn Strip | Heat +0 |
| **Duel** | Click Werewolf → "Challenge to honorable duel!" | Extra laugh line | Fails but buys time |

### Pig Hint Ladder
1. "This isn't a combat puzzle. It's a path puzzle."
2. "Look for a route that forces the wolf to slow down."
3. "Use the thorns to snag it, then dive into the ditch."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Ignorance | Flags |
|------|--------------|------------|------|-----------|-------|
| Speed | Mud (optional) | Bacon Remains | 0 | 0 | CHASE_FAST |
| Snag | Thorn Strip | None | 0 | 0 | CHASE_SNAG |
| Duel | None | None | 0 | 0 | CHASE_COMEDY |

---

## ROOM 03 — Ditch Camp (Night)

**Story beat:** Tank waits, wolf leaves, she falls asleep under leaf blanket.

**Playable:** Tank
**Goal:** Make camp (simple) and set up "missing leg" gag.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Leaf pile | LEG VOID | "My leg is… probably gone in there." | LEAF BLANKET | "A leaf pile. Warm enough to sleep." | Reality shows hint: leg under |
| Ditch wall | DIRT CLIFF | "This wall is judging me." | DITCH WALL | "Climbable… but risky." | Optional escape attempt |
| Puddle | MIRROR WATER | "A tiny lake for tiny heroes." | PUDDLE | "Cold water. Could clean mud." | Removes Mud Face later |
| Roots | GRABBY STRINGS | "Plants trying to hold hands." | ROOT FIBER | "Fibers good for tying." | Craft material |

### Obstacle: "Settle Down"

### Solutions

| Approach | Method | Reward |
|----------|--------|--------|
| **Leaf blanket** | Use leaf pile → sleep | Leaf Blanket in morning |
| **Leaf wrap (better)** | Combine Leaf Blanket + Root Fiber | Leaf Wrap (heat shield/padding) |
| **Tank punch bed** | Creates comfy pit | Heat +1 (loud echo) |

### Pig Hint Ladder
1. "Warmth matters. Leaves are basically free."
2. "If you can turn leaves into something portable, do it."
3. "Grab root fiber and combine it with the leaf blanket."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Ignorance | Flags |
|------|--------------|------------|------|-----------|-------|
| Blanket | Leaf Blanket | None | 0 | 0 | SLEPT_WARM |
| Wrap | Leaf Wrap | None | 0 | 0 | SLEPT_PREPPED |
| Punch bed | None | None | +1 | 0 | LOUD_SLEEP |

---

## ROOM 04 — Morning Miracle (Leg Reveal)

**Story beat:** Tank thinks leg is gone; it's pins and needles; miracle reveal.

**Playable:** Tank
**Goal:** Teach Vision toggle + complete reveal.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Numb leg | PAIN BEAST | "I can still feel the pain!!!!!!!" | PINS & NEEDLES | "Your leg fell asleep. Stand up." | "Tell Tank" increases Ignorance |
| Leaf pile | LEG VOID | "I'm scared to look." | LEAVES | "Your leg is under this." | Key hotspot |
| Backpack strap | HERO BELT | "I should look cool while panicking." | BACKPACK STRAP | "Tighten it. You'll need both hands later." | Minor QoL |

### Obstacle: Reveal Leg

### Solutions

| Approach | Method |
|----------|--------|
| **Reality (direct)** | Examine leaf pile → "Pull leaves" |
| **Tank (theatrical)** | Click "Pretend struggle" 3x → falls → leaves scatter |
| **Comedy** | "Scream MIRACLE" → screen shake → leaves fall |

### Pig Hint Ladder
1. "The leg isn't gone. Something is covering it."
2. "Check what you used as a blanket."
3. "Click the leaf pile in Reality Vision and pull the leaves off."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Ignorance | Flags |
|------|--------------|------------|------|-----------|-------|
| Reality | Leaf Blanket (if not already) | None | 0 | +1 (if Told) | LEG_REVEALED |
| Theatrical | None | None | 0 | 0 | LEG_REVEALED_FUNNY |
| Scream | None | None | 0 | 0 | LEG_REVEALED_LOUD |

---

## ROOM 05 — Lost Rock (Poison Picnic Loot)

**Story beat:** Tank eats poisonous mushrooms and sap bark; survives due to ignorance.

**Playable:** Tank
**Goal:** Decide how to use "poison" items (food, bait, or hazard).

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Mushrooms | POWER NUGGETS | "Nature candy." | POISONOUS MUSHROOMS | "Bad idea. Unless Tank never learns." | Core Ignorance tutorial |
| Sap bark | TREE JERKY | "Crunchy snack stick." | SAP-COATED BARK | "Poison sap. Sticky." | Craft bait/hazard |
| Backpack | TREASURE SACK | "I definitely earned this." | STOLEN BACKPACK | "This belonged to a child." | Optional moral line |

### Obstacle: Eat or Keep?

### Solutions

| Approach | Method | Benefit | Consequence |
|----------|--------|---------|-------------|
| **Tank route (stay ignorant)** | Eat without inspecting | No negative effect (Tank logic) | Ignorance +0, Flag: DUMB_LUCK_ACTIVE |
| **Reality route (learn truth)** | Inspect in Reality Vision | Unlock craft: Antidote-ish Tea | Ignorance +1, Sick Timer if eaten |
| **Utility route** | Don't eat—keep as Bait/Hazard | Safer stealth later | Morale +1 when Pig recruited |

### Pig Hint Ladder
1. "Food can be a tool, not just a stat refill."
2. "If you inspect it too hard, Tank 'learns' and the rules change."
3. "Keep the mushrooms as bait unless you're sure you want Tank to understand poison."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Ignorance | Flags |
|------|--------------|------------|------|-----------|-------|
| Eat ignorant | None | Mushrooms, Bark | 0 | 0 | DUMB_LUCK_ACTIVE |
| Inspect + eat | None | Mushrooms, Bark | 0 | +1 | SICK_TIMER |
| Keep tools | Mushrooms, Bark | None | 0 | 0 | BAIT_READY |

---

## ROOM 06 — Road of Monsters + Gas Station

**Story beat:** Cars are "monsters," police show up, gas truck hits pump, explosion launches Tank.

**Playable:** Tank
**Goal:** Manage chaos; explosion is inevitable, but outcomes vary.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Road | DARK LINE OF DOOM | "Why is the ground… striped?" | ROADWAY | "Active traffic. Dangerous." | |
| Cars | SKY MONSTERS | "Back off, flying beasts!" | CARS | "People inside. Don't smash." | |
| Gas truck | MEGA MONSTER | "The boss monster!" | FUEL TRUCK | "Flammable. Bad near sparks." | |
| Pump station | GAS SHRINE | "A temple that smells like fire." | GAS PUMPS | "Leak risk. Explosion risk." | Reality clue |
| Police | MONSTER BACKUP | "The monsters called friends!" | POLICE | "They will escalate Heat." | |

### Obstacle: Stop Tank from Crushing Citizens (or redirect)

### Solutions

| Approach | Method | Reward | Consequence |
|----------|--------|--------|-------------|
| **Tank chaos** | Pick up a car | Helmet (falls off display) | Heat +2 |
| **Redirect** | Use Cone/Rock Chalk to mark fake target | Safe Donut Box pickup | Heat +0 |
| **Reality chain** | Spot leak + spark → trigger accident | Map Flyer + less pursuit | Heat +1 |

### Pig Hint Ladder
1. "You can't fully stop the big boom. You can choose what you carry into it."
2. "Redirect Tank's 'hero' energy to something that isn't a car."
3. "Use cones/chalk to mark a decoy target, then grab the donut box before the explosion."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Ignorance | Flags |
|------|--------------|------------|------|-----------|-------|
| Chaos | Helmet | Possibly Donut Box | +2 | 0 | POLICE_ESCALATED |
| Redirect | Donut Box, Cone | None | 0 | 0 | CIVILIANS_SAVED |
| Reality accident | Map Flyer | None | +1 | +1 (if Told) | CONTROLLED_BOOM |

---

## ROOM 07 — Space Drift + Donut Compass

**Story beat:** Tank flies into space, follows donut smell, swims back; narrator science lesson.

**Playable:** Tank
**Goal:** Return to atmosphere; choose what knowledge Tank learns.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Earth | GIANT BLUE SNACK PLATE | "Home is down-ish." | EARTH | "Your destination. Orient yourself." | |
| Donut scent | CHOCO COMPASS | "The smell points… that way!" | SMELL TRAIL | "Psychological cue. But it works." | |
| "Science lesson" overlay | WORD STORM | "Too many smart words." | GRAVITY NOTES | "Rotate arrows to point 'down'." | Mini puzzle |

### Obstacle: Get Back to Earth

### Solutions

| Approach | Method |
|----------|--------|
| **Tank route** | Follow donut scent; rhythm swim clicks |
| **Reality route** | Rotate gravity arrows until "down → Earth" |
| **Sacrifice route** | Drop an item to "go faster" (comedy physics) |

### Pig Hint Ladder
1. "Pick a navigation method: smell or logic."
2. "The gravity notes aren't flavor — they're a dial puzzle."
3. "Rotate the arrows so 'down' points at Earth, then commit to the swim rhythm."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Ignorance | Flags |
|------|--------------|------------|------|-----------|-------|
| Smell swim | Space Soot | None | 0 | 0 | RETURN_BY_SMELL |
| Gravity notes | Space Soot | None | 0 | +1 (if Told) | RETURN_BY_LOGIC |
| Drop item | Faster reentry | One chosen item | 0 | 0 | SACRIFICE_BOOST |

---

## ROOM 08 — Re-entry Fire + Motorcycle

**Story beat:** Friction fire, lands near station, forgets donuts, rides motorcycle.

**Playable:** Tank
**Goal:** Escape area; optionally keep Donut Box.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Fire body | WARM MODE | "I feel warm…" | ON FIRE | "You need to reduce heat." | Quick comedy puzzle |
| Motorcycle | METAL HORSE | "I will ride you to glory." | MOTORCYCLE | "Needs a start method." | |
| Donut box | TREASURE DONUTS | "I… forgot you? No!" | DONUT BOX | "Morale bribe later." | Optional pickup |

### Obstacle: Start Bike and Leave

### Solutions

| Approach | Method | Consequence |
|----------|--------|-------------|
| **Reality start** | Identify controls (button/twist/kick) | Clean |
| **Tank punch start** | Works but breaks panel | Heat +1 |
| **Improvised lever** | Use sign arrow as kick lever | Creative |

### Pig Hint Ladder
1. "Motorcycles start with a sequence, not a fight."
2. "Look for the biggest 'button-like' thing."
3. "Press the red control, then twist the grip, then kick once."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Ignorance | Flags |
|------|--------------|------------|------|-----------|-------|
| Reality start | Optional Donut Box | None | 0 | 0 | BIKE_CLEAN_START |
| Punch start | Optional Donut Box | None | +1 | 0 | BIKE_LOUD_START |
| Lever start | Sign Arrow | None | 0 | 0 | BIKE_IMPROVISED |

---

## ROOM 09 — Pig + Deer Crossing (Recruitment)

**Story beat:** Tank almost hits pig riding deer; pig mad; team-up formed.

**Playable:** Tank
**Goal:** Recruit Pig + Deer; unlock party switching.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Pig | ANGRY BACON MAN | "Why is the bacon yelling?" | PIG (WESTERN) | "He's mad. He's also useful." | Dialogue puzzle |
| Deer | FAST HORSE FRIEND | "A deer! Probably magic." | DEER | "Calm. Observant." | |
| Tight pants | LEG ARMOR | "Those pants mean business." | WORKOUT PANTS | "This pig is committed." | Joke hotspot |

### Obstacle: Convince Pig to Join

### Solutions

| Approach | Method | Consequence |
|----------|--------|-------------|
| **Respect** | Apologize + offer partnership | Morale +1 |
| **Bribe** | Give donuts/food | Morale 0 |
| **Intimidate** | Tank threatens | Morale -1, still joins |

### Pig Hint Ladder
1. "He's not blocking the road. He's blocking you."
2. "Give him a reason: respect, food, or safety."
3. "Apologize first, then offer to share supplies. Don't flex."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Ignorance | Morale |
|------|--------------|------------|------|-----------|--------|
| Respect | Pig Craft Kit, Route Sketch | None | 0 | 0 | +1 |
| Bribe | Pig Craft Kit | Donut Box or Food | 0 | 0 | 0 |
| Intimidate | Pig Craft Kit | None | +1 | 0 | -1 |

---

## ROOM 10 — Oak Tree Camp + Route Board

**Story beat:** Sleep by oak tree; Pig lays out absurd travel plan.

**Playable:** Tank + Pig (switch unlocked)
**Goal:** Establish travel plan UI; first team puzzle.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Oak tree | GIANT SLEEP POLE | "This is a good nap tree." | OAK TREE | "Solid shelter. Low visibility." | |
| Route board | MAP TO CANADA | "Lines! Success!" | ROUTE PLAN | "Brazil → Puerto Rico → Florida → Texas → …Canada?" | Foreshadows Case Files |
| Supplies pile | TEAM TREASURE | "Our loot pile is growing." | SUPPLIES | "Crafting materials and food." | |

### Obstacle: Make Camp Safely (teaches teamwork)

### Solutions

| Approach | Method | Consequence |
|----------|--------|-------------|
| **Pig trap** | Leaf noise trap (stealth) | Standard |
| **Tank guard** | Loud, prevents theft | Heat +1 |
| **Deer listen** | Audio cue mini-puzzle | Morale +1 if success |

### Pig Hint Ladder
1. "We need sleep. Sleep needs safety."
2. "You can guard, or you can set a trap. Traps are quieter."
3. "As Pig, place the leaf trap by the trail, then switch back to Tank."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Morale | Flags |
|------|--------------|------------|------|--------|-------|
| Trap | None | None | 0 | +1 | CAMP_SAFE |
| Guard | None | None | +1 | 0 | CAMP_LOUD |
| Deer listen | Hint Token | None | 0 | +1 | CAMP_ALERT |

---

## ROOM 11 — Breakfast + Brazil Edge (Prep to Sea)

**Story beat:** Breakfast mini donuts + spinach; drive to edge of Brazil; Pig made life jacket for "Mista' Snuggles."

**Playable:** Tank + Pig + Deer
**Goal:** Craft life jacket; launch.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Mini donuts | TINY HERO RINGS | "Breakfast of champions." | MINI DONUTS | "Bribe material + morale." | |
| Spinach | LEAF POWER | "Green… victory." | SPINACH LEAVES | "Food + crafting stuffing." | |
| Life jacket | DEER ARMOR | "Snuggles is now invincible." | LIFE JACKET | "Needs buoyant stuffing + straps." | Core craft |
| Driftwood | FLOAT STICKS | "Ocean bones!" | DRIFTWOOD | "Buoyant. Good." | |

### Obstacle: Life Jacket Must Pass Float Test

### Solutions

| Approach | Method | Result |
|----------|--------|--------|
| **Pig craft** | Cloth + rope + driftwood floats | Best |
| **Tank overbuild** | Too heavy, but works | Slows raft puzzles |
| **Deer fitting** | Strap-tightness mini puzzle | Morale +1 |

### Pig Hint Ladder
1. "A life jacket is straps + floaty stuff."
2. "Driftwood floats. Use it."
3. "As Pig, combine rope + cloth + driftwood into the life jacket."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Morale | Flags |
|------|--------------|------------|------|--------|-------|
| Pig craft | Life Jacket (good), Oar | Rope, cloth | 0 | +1 | JACKET_GOOD |
| Overbuild | Life Jacket (bulky) | Extra driftwood | 0 | 0 | RAFT_SLOW |
| Deer fit | Life Jacket (stable) | None | 0 | +1 | JACKET_FIT |

---

## ROOM 12 — Caribbean Raft + Case Files (Fog)

**Story beat:** Case files timestamps; midnight; fog; land ahoy.

**Playable:** Tank + Pig
**Goal:** Navigate fog; introduce "Case File page" mini UI puzzle.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Fog | MOIST WALL | "The air is… wet." | FOG BANK | "Visibility is near zero." | |
| Case file page | OFFICIAL ADVENTURE PAPER | "This paper knows our destiny." | CASE FILES | "Dates don't add up. That's… important." | Meta clue |
| Oar | WATER SPOON | "Row row row row!" | OAR | "Your only steering." | |

### Obstacle: Find Land

### Solutions

| Approach | Method |
|----------|--------|
| **Sound route** | Follow gull/waves (audio cue) |
| **Star route** | Reality Vision aligns stars with route sketch |
| **Tank echo** | Shout "Land ahoy!"; click direction with loudest echo |

### Pig Hint Ladder
1. "We need a navigation cue: sound, stars, or… Tank noises."
2. "If you can't see, listen. The birds know."
3. "Use the oar twice toward the gulls, then once toward the echo."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Ignorance | Flags |
|------|--------------|------------|------|-----------|-------|
| Sound | Bottle Note (optional) | None | 0 | 0 | LAND_BY_SOUND |
| Stars | None | None | 0 | +1 (if Told) | LAND_BY_STARS |
| Echo | None | None | 0 | 0 | LAND_BY_ECHO |

---

## ROOM 13 — Puerto Rico Motel + Dock Boat

**Story beat:** Motel night; dawn; sneak to dock; "steal/borrow" boat.

**Playable:** Party
**Goal:** Get room + get boat via cartoon logic.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Motel clerk | SLEEP GATEKEEPER | "Give me a bed, tiny human!" | FRONT DESK CLERK | "They want payment or a reason." | Dialogue puzzle |
| Dock sign | BOAT RULE PAPER | "Rules! My weakness!" | DOCK NOTICE | "There's a ridiculous 'borrow form' posted." | Comedy safe "theft" |
| Stamp | INK SMASHER | "This makes papers legal." | TOY STAMP | "A stamp. Makes forms 'official'." | |

### Obstacle A: Get a Room

| Approach | Method | Consequence |
|----------|--------|-------------|
| **Trade** | Donuts/food | Standard |
| **Charm** | Pig + Deer cuteness | Comedy |
| **Tank intimidate** | Works | Morale -1 |

### Obstacle B: Get a Boat (cartoon form puzzle)

| Approach | Method | Consequence |
|----------|--------|-------------|
| **Paper route** | Find form → stamp it → "boat token" | Clean |
| **Tank lift** | Loud but funny | Heat +1 |
| **Rope untangle** | Deer holds, Pig solves knot | Morale +1 |

### Pig Hint Ladder
1. "We need paperwork or distraction."
2. "Look for a posted notice near the dock."
3. "Get the borrow form, stamp it at the motel desk, then show it to the dock gate."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Morale | Flags |
|------|--------------|------------|------|--------|-------|
| Paper boat | Boat Token, Keycard | None | 0 | +1 | BOAT_LEGALISH |
| Tank lift | Boat Token | None | +1 | 0 | BOAT_LOUD |
| Rope route | Boat Token, Rope (kept) | None | 0 | +1 | BOAT_CLEAN |

---

## ROOM 14 — Florida Dock → Airport Entry

**Story beat:** Sail Florida; get car; hide in trees; sneak past cameras into airport.

**Playable:** Party
**Goal:** Get into airport.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Trees | HIDE STICKS | "Nature camouflage!" | TREE LINE | "Conceal the car here." | |
| Cameras | WALL EYEBALLS | "The walls are watching!" | SECURITY CAMERAS | "Timed sweep. Watch pattern." | |
| Vest | INVISIBLE CLOTH | "This makes me official." | REFLECTIVE VEST | "Disguise item. Works on NPC logic." | |

### Obstacle: Enter Building

| Approach | Method | Consequence |
|----------|--------|-------------|
| **Disguise route** | Vest + clipboard | Morale +1 |
| **Tank distraction** | Tank "saves" someone from object | Heat +1 |
| **Maintenance route** | Find "Authorized Only" sign; Pig talks | Standard |

### Pig Hint Ladder
1. "Airports ignore confident people with clipboards."
2. "There's a vest around here for 'workers.'"
3. "Wear the vest, hold the clipboard, then walk past the cameras during their sweep."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Morale | Flags |
|------|--------------|------------|------|--------|-------|
| Disguise | Clipboard, Vest | None | 0 | +1 | AIRPORT_IN_CLEAN |
| Distraction | None | None | +1 | 0 | AIRPORT_IN_LOUD |
| Maintenance | Keycard use | None | 0 | 0 | AIRPORT_IN_SIDE |

---

## ROOM 15 — Suitcase Selection + Luggage Room

**Story beat:** Crawl into suitcase tagged Texas; deer in different suitcase; cold luggage room.

**Playable:** Party
**Goal:** Choose correct suitcase + reunite deer.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Tag | DESTINY PAPER | "This paper chooses our future." | LUGGAGE TAG | "Destination text + barcode." | Device-6-ish text puzzle |
| Conveyor | MOVING FLOOR SNAKE | "The ground is alive!" | CONVEYOR BELT | "Routing depends on barcode station." | |
| Red suitcase | HERO HOUSE | "This is our home now." | RED SUITCASE | "You're inside this." | |
| Gray suitcase | DEER BOX | "Snuggles is in the other box!" | GRAY SUITCASE | "Deer location." | Must reunite |

### Obstacle A: Get Texas Route

| Approach | Method | Consequence |
|----------|--------|-------------|
| **Reality tag puzzle** | Rotate/fold until TEXAS visible | Ignorance +1 if Told |
| **Pig forge** | Stickers/marker to modify tag | Standard |
| **Tank rip** | Loud but works | Heat +1 |

### Obstacle B: Keep Deer Close

| Approach | Method | Consequence |
|----------|--------|-------------|
| **Rope link** | Suitcases linked | Standard |
| **Sound cue** | Follow deer tapping | Morale +1 |
| **Stop belt** | Tank shoulder-barges controls | Heat +1 |

### Pig Hint Ladder
1. "The tag decides the belt route."
2. "Make sure the word 'Texas' is clearly readable."
3. "Rotate the tag until TEXAS aligns, then scan it at the beep station."

### Branching Inventory Outcome

| Path | Items Gained | Items Lost | Heat | Ignorance | Flags |
|------|--------------|------------|------|-----------|-------|
| Tag puzzle | Texas Tag (kept) | None | 0 | +1 (if Told) | ROUTE_TEXAS |
| Forge | Sticker Sheet used | None | 0 | 0 | ROUTE_TEXAS_FAKE |
| Rip | None | None | +1 | 0 | ROUTE_CHAOS |
| Rope reunite | Rope spent? (kept) | None | 0 | +1 Morale | DEER_SAFE |
| Belt stop | None | None | +1 | 0 | DEER_SAVED_LOUD |

---

## ROOM 16 — Plane Hold: Siren + Crash

**Story beat:** Siren; flight attendant; crash landing into Amazon; "life vest—CRASH!"

**Playable:** Party
**Goal:** Prep for crash; determine post-crash inventory.

### Hotspots

| Hotspot | Tank Vision Hover | Tank Vision Inspect | Reality Vision Hover | Reality Vision Inspect | Notes |
|---------|-------------------|---------------------|----------------------|------------------------|-------|
| Siren light | PANIC LAMP | "The plane is screaming." | WARNING LIGHT | "Crash imminent." | Timer begins |
| Life vests | FLOAT SHIRTS | "Put on the puffy shirts!" | LIFE VESTS | "One per character." | |
| Cargo straps | HUG BELTS | "Strap everything down!" | CARGO STRAPS | "Prevent inventory loss." | |
| Loose baggage | FLYING BRICKS | "Everything wants to escape!" | UNSECURED BAGS | "These will scatter on impact." | |

### Obstacle: Crash Prep (timed, but forgiving)

### Solutions

| Approach | Method | Result |
|----------|--------|--------|
| **Pig best prep** | Vest all + strap deer + secure bag | Best inventory retention |
| **Tank brace** | Saves deer, items fly | Lose 1–2 random items |
| **Chaos** | Do nothing | Survive, but wrong items (spoons, socks) |

### Pig Hint Ladder
1. "Secure the deer. Secure yourselves. Then secure the stuff."
2. "Straps prevent losing inventory. Start there."
3. "Put vests on everyone, strap the gray suitcase, then strap the supplies bag."

### Branching Inventory Outcome

| Path | Items Kept | Items Lost | Heat | Morale | Flags |
|------|------------|------------|------|--------|-------|
| Best prep | Keep most key items | Lose 0–1 | 0 | +1 | CRASH_PREPPED |
| Tank brace | Keep deer safe | Lose 1–2 | 0 | 0 | CRASH_SLOPPY |
| Do nothing | Keep deer (scripted) | Lose 2–3, gain junk | 0 | -1 | CRASH_CHAOS |
