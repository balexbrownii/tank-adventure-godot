@tool
extends PopochiuRoom
## Room 1 - Wanted Camp (Night) - TUTORIAL
## Tank is camping and hiding from German soldiers after eating
## the commander's bacon sandwich. This is the opening room.

const Data := preload('room_wanted_camp_state.gd')
var state: Data = load("res://game/rooms/wanted_camp/room_wanted_camp.tres")

## Vision data for hotspots in this room
var vision_data: Dictionary = {
	"wanted_poster": {
		"tank_hover": "IMPORTANT PAPER",
		"tank_inspect": "Someone drew a picture of me! I look GREAT!",
		"reality_hover": "Wanted Poster",
		"reality_inspect": "A wanted poster. For you. With a large reward."
	},
	"campfire": {
		"tank_hover": "WARM FRIEND",
		"tank_inspect": "The fire is my friend! It keeps the monsters away!",
		"reality_hover": "Campfire",
		"reality_inspect": "A small campfire. Probably visible from far away..."
	},
	"backpack": {
		"tank_hover": "TREASURE SACK",
		"tank_inspect": "A bag full of mysteries and probably food!",
		"reality_hover": "Backpack (Dirty)",
		"reality_inspect": "A worn backpack. Looks like it's been through a lot."
	},
	"bacon_remnants": {
		"tank_hover": "DELICIOUS MEMORIES",
		"tank_inspect": "The remains of the BEST sandwich ever!",
		"reality_hover": "Bacon Sandwich Remnants",
		"reality_inspect": "Crumbs from the commander's sandwich. Still smells strongly."
	},
	"bush_line": {
		"tank_hover": "FLUFFY HIDING PLACE",
		"tank_inspect": "Perfect for hiding! Or napping!",
		"reality_hover": "Dense Bushes",
		"reality_inspect": "Thick bushes. Good cover for sneaking."
	},
	"river_path": {
		"tank_hover": "WATER ROAD",
		"tank_inspect": "The path leads to water! Water is good!",
		"reality_hover": "Path to River",
		"reality_inspect": "A trail leading to the river. Possible escape route."
	},
	"vine_coil": {
		"tank_hover": "NATURE ROPE",
		"tank_inspect": "A natural rope! Nature is so thoughtful!",
		"reality_hover": "Vine Coil",
		"reality_inspect": "Sturdy vines. Could be useful for climbing or tying."
	},
	"rock_pile": {
		"tank_hover": "PET ROCKS",
		"tank_inspect": "So many rocks! I should collect them all!",
		"reality_hover": "Rock Pile",
		"reality_inspect": "A pile of fist-sized rocks. Good for throwing... or hiding behind."
	}
}


#region Virtual ####################################################################################
func _on_room_entered() -> void:
	# Register vision data for this room
	for hotspot_id in vision_data:
		TankVision.register_hotspot_data("WantedCamp", hotspot_id, vision_data[hotspot_id])


func _on_room_transition_finished() -> void:
	# Intro disabled for testing
	pass


#endregion

#region Public ####################################################################################

## Trigger soldier arrival - called after player explores a bit
func trigger_soldiers() -> void:
	if state.soldiers_arrived:
		return

	state.soldiers_arrived = true

	await E.queue([
		"Distant sounds of marching...",
		"German Voice: Tennnn HoouT!!!",
		"Tank: Uh oh...",
		"Two German soldiers emerge from the darkness",
		"Soldier 1: I see hur!",
		"Soldier 2: Ze bacon thief!",
		"Tank: I'm not a thief! I was HUNGRY!"
	])

	# Show encounter options
	await D.SoldierEncounter.start()


## Execute Brawn solution: Combat combo
func execute_brawn_solution() -> void:
	state.solution_used = "brawn"
	state.escaped = true
	GameState.solve_puzzle("soldier_escape", GameState.Approach.BRAWN)
	GameState.modify_heat(1)

	await E.queue([
		"Tank: TIME FOR ACTION!",
		"Tank rushes at Soldier 1",
		"HEADLOCK!",
		"Soldier 1: Ack!",
		"Tank pivots to Soldier 2",
		"KICK!",
		"Soldier 2: Mein shin!",
		"Tank finishes with a dramatic chop",
		"CHOP!",
		"Both soldiers collapse",
		"Tank: That's what happens when you mess with Tank!",
		"Tank dramatically tosses both soldiers into the bushes"
	])

	await _escape_sequence()


## Execute Brains solution: Sneak with bacon lure
func execute_brains_solution() -> void:
	state.solution_used = "brains"
	state.escaped = true
	GameState.solve_puzzle("soldier_escape", GameState.Approach.BRAINS)

	await E.queue([
		"Tank: I have an idea...",
		"Tank quietly drops bacon crumbs near the bushes",
		"The smell wafts toward the soldiers",
		"Soldier 1: ...Do you smell zat?",
		"Soldier 2: Ja... smells like... bacon?",
		"Both soldiers drift toward the bushes, sniffing",
		"Tank sneaks behind the rock pile",
		"Soldier 1: It's coming from ze bushes!",
		"Tank slips away while they're distracted",
		"Tank: (whispered) Too easy!"
	])

	# Remove bacon crumbs since they were used
	if I.BaconCrumbs.is_in_inventory():
		I.BaconCrumbs.queue_remove()
	state.used_bacon_lure = true

	await _escape_sequence()


## Execute Bizarre solution: Bacon Guardian tribute
func execute_bizarre_solution() -> void:
	state.solution_used = "bizarre"
	state.escaped = true
	GameState.solve_puzzle("soldier_escape", GameState.Approach.BIZARRE)
	GameState.modify_morale(5)

	await E.queue([
		"Tank: Wait! You're not soldiers!",
		"Soldier 1: Vat?",
		"Tank: You're the BACON GUARDIANS!",
		"Soldier 2: Ve are vat now?",
		"Tank approaches dramatically",
		"Tank: I shall offer you a tribute!",
		"Tank throws bacon crumbs into the campfire",
		"The fire crackles with a bacon-scented flare",
		"Soldier 1: ...",
		"Soldier 2: ...",
		"Tank: The sacred bacon ritual is complete!",
		"Tank: You may now return to your bacon duties!",
		"The soldiers exchange confused glances",
		"Soldier 1: She is... completely insane.",
		"Soldier 2: Ja. Let's just... go.",
		"The soldiers slowly back away",
		"Tank: FAREWELL, BACON GUARDIANS!"
	])

	await _escape_sequence()


## Fail-forward: Tank gets caught
func execute_fail_forward() -> void:
	state.was_caught = true
	GameState.modify_heat(2)

	await E.queue([
		"The soldiers grab Tank",
		"Soldier 1: Got you!",
		"Tank: You'll never take me alive!",
		"Soldier 2: You ARE alive.",
		"Tank: Oh. Right.",
		"Short interrogation begins",
		"Soldier 1: Vhy did you eat ze commander's sandwich?!",
		"Tank: I'm not the one who ate it.",
		"Soldier 2: Ve SAW you eat it.",
		"Tank: No you didn't.",
		"Soldier 1: You have bacon grease on your face.",
		"Tank: ...I'm a tree.",
		"Soldier 2: Vat.",
		"Tank: Trees have bacon grease sometimes.",
		"The soldiers stare in disbelief",
		"Soldier 1: I... I can't do zis anymore.",
		"Soldier 2: Let's just report back. Zis is above our pay grade.",
		"The soldiers release Tank and walk away, muttering",
		"Tank: I AM A VERY CONVINCING TREE!"
	])

	# Lose the poster scrap if had it
	if I.PosterScrap.is_in_inventory():
		await E.queue([
			"The soldiers confiscated the poster scrap",
			"Tank: Hey! That was mine!"
		])
		I.PosterScrap.queue_remove()

	await _escape_sequence()


#endregion

#region Private ####################################################################################

func _play_intro_sequence() -> void:
	await E.queue([
		"Night falls over a small forest clearing",
		"A campfire crackles softly",
		"Tank sits by the fire, looking satisfied",
		"Tank: That was the BEST sandwich.",
		"Tank: Worth it.",
		"Tank pats her stomach",
		"Tank: Now I just need to get to... somewhere.",
		"Tank: Canada? Was it Canada?",
		"Tank: Somewhere north. Definitely north.",
		"Tank looks around the camp",
		"Tank: I should probably gather some supplies before moving on."
	])


func _escape_sequence() -> void:
	# Different dialogue based on items collected
	var items_collected := 0
	if state.backpack_taken:
		items_collected += 1
	if state.vine_taken:
		items_collected += 1
	if state.rock_taken:
		items_collected += 1

	if items_collected >= 2:
		await E.queue([
			"Tank: Time to go!",
			"Tank: At least I got some good stuff.",
			"Tank heads toward the river path"
		])
	else:
		await E.queue([
			"Tank: Time to go!",
			"Tank: I probably should have grabbed more supplies...",
			"Tank: Oh well! ADVENTURE AWAITS!"
		])

	# Transition to next room
	E.goto_room("WerewolfChase")


#endregion
