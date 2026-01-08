@tool
extends PopochiuRoom
## Room 10 - Oak Tree Camp + The Ridiculous Plan
## Pig outlines the travel plan; party camps at oak tree; breakfast scene.
## This teaches party play and introduces the planning board.

const Data := preload('room_oak_tree_camp_state.gd')
var state: Data = load("res://game/rooms/oak_tree_camp/room_oak_tree_camp.tres")

## Vision data for hotspots in this room
var vision_data: Dictionary = {
	"oak_tree": {
		"tank_hover": "THE WISE ELDER",
		"tank_inspect": "The wisest tree in the land! It knows things!",
		"reality_hover": "Oak Tree",
		"reality_inspect": "A large oak tree. Good for shelter and shade."
	},
	"camp_spot": {
		"tank_hover": "HOME BASE",
		"tank_inspect": "Our fortress for the night! Impenetrable!",
		"reality_hover": "Camp Spot",
		"reality_inspect": "A cleared area under the tree. Good for sleeping."
	},
	"plan_board": {
		"tank_hover": "MAP TO CANADA IN 3 EASY STEPS",
		"tank_inspect": "Step 1: Go! Step 2: Keep going! Step 3: CANADA!",
		"reality_hover": "Route Plan",
		"reality_inspect": "Pig's detailed route: Brazil coast, Caribbean crossing, Puerto Rico, Florida, then north."
	},
	"mini_donuts": {
		"tank_hover": "PRECIOUS TREASURE",
		"tank_inspect": "THE DONUTS! We must protect them at ALL costs!",
		"reality_hover": "Mini Donuts (Supplies)",
		"reality_inspect": "Travel rations. Should probably secure these overnight."
	},
	"spinach_leaves": {
		"tank_hover": "GREEN POWER",
		"tank_inspect": "Mr. Snuggles' power food! Makes him extra fluffy!",
		"reality_hover": "Spinach Leaves",
		"reality_inspect": "Fresh greens for the deer. Nutritious."
	},
	"deer_saddle": {
		"tank_hover": "FLUFFY HORSE SEAT",
		"tank_inspect": "Where Pig sits on the fluffy horse!",
		"reality_hover": "Mr. Snuggles' Saddle",
		"reality_inspect": "The saddle Pig uses to ride Mr. Snuggles. Well-maintained."
	}
}


#region Virtual ####################################################################################
func _on_room_entered() -> void:
	# Register vision data for this room
	for hotspot_id in vision_data:
		TankVision.register_hotspot_data("OakTreeCamp", hotspot_id, vision_data[hotspot_id])


func _on_room_transition_finished() -> void:
	if not state.intro_complete:
		await _play_intro_sequence()
		state.intro_complete = true


#endregion

#region Public ####################################################################################

## Execute Brains solution: Pig sets up noise trap
func execute_brains_solution() -> void:
	state.solution_used = "brains"
	state.camp_secured = true
	GameState.solve_puzzle("camp_security", GameState.Approach.BRAINS)
	GameState.modify_morale(5)

	await E.queue([
		"Pig: Alright, let me set up somethin'.",
		"Pig gathers leaves and string from the supplies",
		"Pig: Simple noise trap. Anythin' comes near, we'll hear it.",
		"Tank: That's so SMART!",
		"Pig: It's just basic survival skills.",
		"Tank: SMART SURVIVAL SKILLS!",
		"Pig: ...Thank you.",
		"The trap is set around the camp perimeter"
	])

	await _complete_camp_setup()


## Execute Brawn solution: Tank stands guard dramatically
func execute_brawn_solution() -> void:
	state.solution_used = "brawn"
	state.camp_secured = true
	GameState.solve_puzzle("camp_security", GameState.Approach.BRAWN)
	GameState.modify_heat(1)

	await E.queue([
		"Tank: I WILL PROTECT US!",
		"Tank strikes a dramatic guard pose",
		"Pig: You're gonna stand there all night?",
		"Tank: YES!",
		"Pig: ...You know you need sleep too, right?",
		"Tank: SLEEP IS FOR THE WEAK!",
		"Mr. Snuggles settles down for a nap",
		"Pig: Fine. Fine. Wake me if anythin' happens.",
		"Tank stands guard with intense determination",
		"(Distant animals flee from Tank's energy)"
	])

	await _complete_camp_setup()


## Execute Bizarre solution: Mr. Snuggles listens for danger
func execute_bizarre_solution() -> void:
	state.solution_used = "bizarre"
	state.camp_secured = true
	GameState.solve_puzzle("camp_security", GameState.Approach.BIZARRE)
	GameState.modify_morale(10)

	await E.queue([
		"Tank: What about the fluffy horse?",
		"Pig: ...Mr. Snuggles?",
		"Tank: Can he listen for danger?",
		"Pig: He's a deer, not a- actually...",
		"Pig: Deer DO have excellent hearing.",
		"Mr. Snuggles' ears perk up attentively",
		"Tank: SEE! He's already doing it!",
		"Pig: Well I'll be...",
		"Mr. Snuggles turns to face different directions, ears rotating",
		"Pig: Natural early warning system. Not bad, Tank.",
		"Tank: I'm VERY smart about animals!"
	])

	await _complete_camp_setup()


## Fail-forward: Raccoon steals the donuts
func execute_fail_forward() -> void:
	state.raccoon_stole_donuts = true
	GameState.modify_morale(-10)

	await E.queue([
		"Night falls without securing the camp",
		"...",
		"Everyone is asleep",
		"...",
		"RUSTLE RUSTLE",
		"Tank: Huh? What?",
		"A RACCOON IS RUNNING AWAY WITH THE DONUTS",
		"Tank: NOOOOOO!",
		"Tank: COME BACK HERE!",
		"Pig: What in tarnation?!"
	])

	# Mini chase sequence
	await _raccoon_chase()


## Show the plan board
func show_plan_board() -> void:
	state.plan_viewed = true

	await E.queue([
		"Pig: Alright, gather 'round. Here's the plan.",
		"Pig draws in the dirt with a stick",
		"Pig: We're HERE.",
		"Pig makes a dot",
		"Pig: Canada is THERE.",
		"Pig makes another dot very far away",
		"Tank: That looks far.",
		"Pig: It IS far. But we got a route."
	])

	await D.PlanBoardIntro.start()


#endregion

#region Private ####################################################################################

func _play_intro_sequence() -> void:
	await E.queue([
		"The group arrives at the oak tree",
		"Pig: This'll do. Good cover, good ground.",
		"Tank: It's a BEAUTIFUL tree!",
		"Tank hugs the tree",
		"Mr. Snuggles begins grazing nearby",
		"Pig: Alright, we should secure the camp for the night.",
		"Pig: Don't want any critters gettin' into our supplies."
	])


func _complete_camp_setup() -> void:
	await E.queue([
		"The camp is set up for the night",
		"...",
		"Morning arrives",
		"Pig: Rise and shine, everyone.",
		"Tank: Is it donut time?!",
		"Pig: Breakfast first, then I'll show you the plan."
	])

	# Breakfast scene
	await _breakfast_scene()


func _breakfast_scene() -> void:
	state.breakfast_done = true

	if state.raccoon_stole_donuts:
		await E.queue([
			"Pig: About those donuts...",
			"Tank: We don't talk about the donuts.",
			"Pig: Fine. Here's some spinach.",
			"Tank: ...I miss the donuts.",
			"Mr. Snuggles happily munches spinach"
		])
	else:
		await E.queue([
			"Pig: Here, have some mini donuts.",
			"Tank: YAY!",
			"Tank eats several donuts at once",
			"Pig: Save some for later!",
			"Tank: (mouth full) Mmmph okay!",
			"Mr. Snuggles nibbles on spinach leaves",
			"Pig: Good deer."
		])

	await E.queue([
		"Pig: Now, let's talk about the route.",
		"Pig: Come look at the plan board."
	])

	await show_plan_board()


func _raccoon_chase() -> void:
	await E.queue([
		"Tank sprints after the raccoon",
		"Tank: GIVE BACK THE DONUTS!",
		"The raccoon is surprisingly fast",
		"Pig: Just let it go! We got more supplies!",
		"Tank: BUT... THE... DONUTS...",
		"The raccoon disappears into the bushes",
		"Tank: ...",
		"Tank: I'll remember this, raccoon.",
		"Tank: FOREVER."
	])

	await E.queue([
		"Tank trudges back to camp",
		"Pig: Well, that's one way to wake up.",
		"Tank: I hate raccoons now.",
		"Pig: Noted. Let's just get some breakfast and plan our route."
	])

	# Continue to breakfast with no donuts
	await _breakfast_scene()


func _complete_planning() -> void:
	state.route_sketch_received = true
	I.RouteSketch.queue_add()

	await E.queue([
		"Pig: Here, take this sketch of the route.",
		"Tank receives Route Sketch",
		"Tank: It's beautiful!",
		"Pig: It's a rough map.",
		"Tank: A BEAUTIFUL rough map!",
		"Pig: ...Thanks. Now let's pack up and head to the coast.",
		"Pig: Brazil's edge awaits. Then the sea.",
		"Tank: TO ADVENTURE!",
		"Mr. Snuggles stands ready"
	])

	# End of vertical slice / demo
	await E.queue([
		"--- END OF VERTICAL SLICE ---",
		"Thank you for playing!",
		"The adventure continues in the full game..."
	])


#endregion
