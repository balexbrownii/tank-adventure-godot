@tool
extends PopochiuRoom
## Room 2 - Werewolf Chase Path
## Tank runs from a giant werewolf, trips on a vine, falls into a ditch.
## This is a point-and-click chase sequence.

const Data := preload('room_werewolf_chase_state.gd')
var state: Data = load("res://game/rooms/werewolf_chase/room_werewolf_chase.tres")

## Vision data for hotspots in this room
var vision_data: Dictionary = {
	"split_trail_sign": {
		"tank_hover": "HELPFUL ARROWS",
		"tank_inspect": "The arrows point... everywhere! Very helpful!",
		"reality_hover": "Crooked Trail Sign",
		"reality_inspect": "A broken trail sign. Hard to tell which way is safe."
	},
	"vine_tripline": {
		"tank_hover": "DECORATIVE STRING",
		"tank_inspect": "Nature's decoration! How pretty!",
		"reality_hover": "Vine Tripline",
		"reality_inspect": "A vine stretched across the path. Tripping hazard."
	},
	"hollow_log": {
		"tank_hover": "NATURE TUNNEL",
		"tank_inspect": "A secret passage! For adventurers!",
		"reality_hover": "Hollow Log",
		"reality_inspect": "A fallen log. Could crawl through it."
	},
	"thorn_bush": {
		"tank_hover": "ANGRY PLANT",
		"tank_inspect": "This plant looks very angry at me!",
		"reality_hover": "Thorn Bush",
		"reality_inspect": "Sharp thorns. Could be useful... or painful."
	},
	"mud_patch": {
		"tank_hover": "CHOCOLATE PUDDLE",
		"tank_inspect": "Ooh, forest chocolate!",
		"reality_hover": "Mud Patch",
		"reality_inspect": "Thick, slippery mud. Watch your step."
	},
	"ditch_edge": {
		"tank_hover": "MYSTERIOUS HOLE",
		"tank_inspect": "A portal to adventure!",
		"reality_hover": "Ditch Edge",
		"reality_inspect": "A deep ditch. Could hide in there."
	},
	"werewolf": {
		"tank_hover": "ARCH NEMESIS",
		"tank_inspect": "The WOLF! My sworn enemy! We have HISTORY!",
		"reality_hover": "Giant Werewolf",
		"reality_inspect": "A massive werewolf. It wants the bacon that's... inside you now."
	}
}


#region Virtual ####################################################################################
func _on_room_entered() -> void:
	# Register vision data for this room
	for hotspot_id in vision_data:
		TankVision.register_hotspot_data("WerewolfChase", hotspot_id, vision_data[hotspot_id])


func _on_room_transition_finished() -> void:
	if not state.chase_started:
		await _start_chase_sequence()


#endregion

#region Public ####################################################################################

## Start the chase - called after room transition
func _start_chase_sequence() -> void:
	state.chase_started = true

	await E.queue([
		"Tank runs through the dark forest",
		"Tank: RUNNING! I'M SO GOOD AT RUNNING!",
		"A massive shadow moves between the trees",
		"Deep growling echoes through the forest",
		"WOLF: I can smell the bacon...",
		"WOLF: Give me what's INSIDE you!",
		"Tank: NEVER! That bacon is MINE now!",
		"Tank: Well, technically it's IN me now!",
		"The werewolf bursts through the trees behind Tank"
	])

	# Show chase options
	await D.WerewolfChaseApproach.start()


## Execute Brawn solution: Fast running sequence
func execute_brawn_solution() -> void:
	state.solution_used = "brawn"
	state.escaped = true
	GameState.solve_puzzle("werewolf_escape", GameState.Approach.BRAWN)

	await E.queue([
		"Tank: SPEED MODE ACTIVATED!",
		"Tank spots the hollow log",
		"Tank: Through the nature tunnel!",
		"Tank dives through the hollow log",
		"WHOOSH!",
		"The wolf crashes into the log, stuck!",
		"WOLF: ARGH!",
		"Tank slides through mud",
		"SPLORCH!",
		"Tank: Wheeeee!"
	])

	# Drop bacon crumbs if player has them
	if I.BaconCrumbs.is_in_inventory():
		await E.queue([
			"Some bacon crumbs fall out of Tank's pocket!",
			"The wolf stops to sniff them",
			"Tank: WORTH IT!"
		])
		I.BaconCrumbs.queue_remove()

	await E.queue([
		"Tank sees the ditch edge",
		"Tank: THE PORTAL TO SAFETY!",
		"Tank jumps into the ditch",
		"THUD!",
		"Tank: Ow. But safe!"
	])

	await _escape_to_ditch()


## Execute Brains solution: Vine decoy
func execute_brains_solution() -> void:
	state.solution_used = "brains"
	state.escaped = true
	GameState.solve_puzzle("werewolf_escape", GameState.Approach.BRAINS)

	await E.queue([
		"Tank: I have an idea...",
		"Tank grabs a nearby vine",
		"Tank: If I snap this branch...",
		"Tank yanks the vine hard",
		"SNAP! CRACK!",
		"A large branch falls to the ground",
		"WOLF: What was that?!",
		"The wolf turns to investigate the sound",
		"Tank: Now's my chance!"
	])

	# Gain thorn item from passing thorn bush
	await E.queue([
		"Tank slips past the thorn bush",
		"Tank: Ouch! But useful!",
		"Tank collects a large thorn"
	])
	I.Thorn.add_to_inventory()
	state.thorn_taken = true

	await E.queue([
		"Tank quietly approaches the ditch",
		"Tank: Almost there...",
		"Tank slides into the ditch",
		"WOLF: WHERE DID SHE GO?!",
		"Tank: (whispered) Bye bye, puppy."
	])

	await _escape_to_ditch()


## Execute Bizarre solution: Honorable duel challenge
func execute_bizarre_solution() -> void:
	state.solution_used = "bizarre"
	state.escaped = true
	state.attempted_duel = true
	GameState.solve_puzzle("werewolf_escape", GameState.Approach.BIZARRE)
	GameState.modify_morale(5)

	await E.queue([
		"Tank stops and turns dramatically",
		"Tank: ARCH NEMESIS!",
		"WOLF: ...What?",
		"Tank: I challenge you to an HONORABLE DUEL!",
		"WOLF: We're not doing this.",
		"Tank: A DUEL TO THE DEATH!",
		"WOLF: I'm just going to eat you.",
		"Tank: NOT UNTIL WE FOLLOW THE ANCIENT RULES!",
		"WOLF: What ancient rules?!",
		"Tank: THE RULES OF THE BACON WARRIORS!",
		"WOLF: ...",
		"The wolf stares in confusion",
		"Tank uses this moment to slowly back away",
		"Tank: First, we must recite the oath!",
		"Tank: 'I, Tank, defender of bacon...'",
		"WOLF: This isn't a thing!",
		"Tank: '...do solemnly swear...'",
		"Tank is now at the ditch edge",
		"Tank: '...to RUN AWAY!'",
		"Tank jumps into the ditch",
		"WOLF: THAT'S NOT AN OATH!",
		"Tank: IT IS NOW!"
	])

	await _escape_to_ditch()


## Fail-forward: Tank faceplants in mud
func execute_fail_forward() -> void:
	state.mud_faceplant = true
	GameState.modify_morale(-5)

	await E.queue([
		"Tank runs in a panic",
		"Tank: WHICH WAY WHICH WAY?!",
		"Tank doesn't see the vine tripline",
		"TRIP!",
		"Tank: WHOA-",
		"SPLAT!",
		"Tank faceplants directly into the mud patch",
		"...",
		"Tank slowly lifts her mud-covered face",
		"Tank: ...I meant to do that.",
		"WOLF: *sneezes* ACH! Mud!",
		"The wolf got mud up its nose!",
		"WOLF: *sneezing fit* I CAN'T SMELL ANYTHING!",
		"Tank: HA! TACTICAL MUD!",
		"Tank scrambles toward the ditch",
		"Tank: Bye puppy!"
	])

	# Give sticky mud as consolation
	await E.queue([
		"Tank notices some sticky mud on her hands",
		"Tank: Ooh, this is really sticky!",
		"Tank: Might be useful!"
	])
	I.StickyMud.add_to_inventory()
	state.sticky_mud_taken = true

	state.escaped = true
	await _escape_to_ditch()


#endregion

#region Private ####################################################################################

func _escape_to_ditch() -> void:
	var collected := 0
	if state.thorn_taken:
		collected += 1
	if state.sticky_mud_taken:
		collected += 1
	if state.hollow_log_bark_taken:
		collected += 1

	if state.mud_faceplant:
		await E.queue([
			"Tank tumbles into the ditch",
			"Tank: Made it!",
			"Tank: ...I have mud EVERYWHERE.",
			"Tank tries to wipe her face",
			"Tank: This is fine. Mud is good for the skin!",
			"Tank: I read that somewhere. Maybe."
		])
	else:
		await E.queue([
			"Tank lands in the ditch",
			"Tank: SAFE!",
			"Tank: Take THAT, arch nemesis!",
			"The wolf howls in frustration above",
			"WOLF: I'll find you! I can smell bacon for MILES!",
			"Tank: (whispered) Not if you can't see me..."
		])

	# Transition to next room
	E.goto_room("DitchHideout")


#endregion
