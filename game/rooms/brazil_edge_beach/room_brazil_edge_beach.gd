@tool
extends PopochiuRoom
## Room 11 - Brazil Edge Beach (Raft Prep)
## Craft Mr. Snuggles' life jacket and launch to sea!
## First full party puzzle - Tank, Pig, and Mr. Snuggles all contribute.

const Data := preload('room_brazil_edge_beach_state.gd')
var state: Data = load("res://game/rooms/brazil_edge_beach/room_brazil_edge_beach.tres")

# Tank Vision labels - buoyancy matters here!
var vision_data: Dictionary = {
	"beach": {
		"tank_hover": "ADVENTURE SHORE",
		"tank_inspect": "The edge of the continent! Beyond lies GLORY!",
		"reality_hover": "Sandy Beach",
		"reality_inspect": "A quiet Brazilian beach. The water looks calm enough for crossing."
	},
	"driftwood": {
		"tank_hover": "FLOATY WOOD THINGS",
		"tank_inspect": "Wood from the sea! It must have magical floating powers!",
		"reality_hover": "Driftwood Pile",
		"reality_inspect": "Bleached driftwood. Would make good flotation material for a life jacket."
	},
	"vine_rope": {
		"tank_hover": "NATURE'S BINDINGS",
		"tank_inspect": "Strong vines! Perfect for tying enemies... or friends!",
		"reality_hover": "Coastal Vines",
		"reality_inspect": "Sturdy vines that could work as rope. Good for strapping things together."
	},
	"cloth_scrap": {
		"tank_hover": "VICTORY BANNER MATERIAL",
		"tank_inspect": "Cloth torn from something! A flag for our raft!",
		"reality_hover": "Trailer Tarp (torn)",
		"reality_inspect": "A piece of tarp from the abandoned trailer. Water-resistant."
	},
	"car_trailer": {
		"tank_hover": "LAND VESSEL (BROKEN)",
		"tank_inspect": "Our noble steed has served us well! Now it rests!",
		"reality_hover": "Abandoned Car + Trailer",
		"reality_inspect": "The motorcycle-towed trailer. Can't take it on the water."
	},
	"waterline": {
		"tank_hover": "THE GATEWAY TO CANADA",
		"tank_inspect": "Through there lies our destiny! CANADA!",
		"reality_hover": "Water's Edge",
		"reality_inspect": "Where the raft will launch. Mr. Snuggles needs a life jacket first."
	}
}


func _on_room_entered() -> void:
	if state.visited_before:
		return

	state.visited_before = true

	# Intro sequence - party arrives at beach
	await E.queue([
		"*The party arrives at the Brazilian coast*",
		"Tank: WE MADE IT TO THE EDGE!",
		"Pig: Whudyue mean 'edge'? It's the ocean, not a cliff.",
	])

	# Check for miracle confidence bonus from Room 4
	var has_confidence = GameState.has_temporary_status("miracle_confidence")
	if has_confidence:
		await C.Tank.say("I feel READY for this crossing!")

	await E.queue([
		"Pig: Mista' Snuggles can't swim too good. We need to build him somethin'.",
		"Mr. Snuggles: *looks at water calmly*",
		"Tank: A LIFE JACKET! I'LL BUILD THE BEST ONE!",
		"Pig: ...or I could help with the plannin' part.",
	])


func _on_room_transition_started() -> void:
	pass


func trigger_life_jacket_puzzle() -> void:
	"""Start the life jacket building dialog."""
	D.LifeJacketBuild.start()


func execute_brains_solution() -> void:
	"""Brains solution: Pig guides efficient craft."""
	state.jacket_crafted = true
	state.solution_used = "brains"

	GameState.solve_puzzle("life_jacket", GameState.Approach.BRAINS)

	await E.queue([
		"Pig: Okay, here's the plan...",
		"Pig: Cloth for the body, driftwood for flotation, vines to secure it.",
		"Tank: *follows instructions surprisingly well*",
		"Pig: ...huh. You're actually pretty good at followin' directions.",
		"Tank: I'm GREAT at following ORDERS!",
	])

	# Craft the life jacket
	await E.queue([
		"*Life jacket assembled efficiently*",
		"Mr. Snuggles: *tries on jacket*",
		"Mr. Snuggles: *nods approvingly*",
		"Pig: Perfect fit. Let's launch.",
	])

	I.LifeJacket.add()
	I.Oar.add()
	I.RaftPatch.add()
	_collect_bonus_items()


func execute_brawn_solution() -> void:
	"""Brawn solution: Tank overbuilds with extra driftwood."""
	state.jacket_crafted = true
	state.solution_used = "brawn"
	state.jacket_overbuilt = true

	GameState.solve_puzzle("life_jacket", GameState.Approach.BRAWN)

	await E.queue([
		"Tank: I KNOW HOW TO DO THIS!",
		"Tank: *grabs ALL the driftwood*",
		"Pig: That's... that's way too much wood.",
		"Tank: MORE FLOATY = MORE SAFE!",
	])

	# Overbuilt jacket
	await E.queue([
		"*Tank builds an enormous flotation device*",
		"Mr. Snuggles: *struggles to lift head*",
		"Tank: He looks SO SAFE!",
		"Pig: He looks like a turtle stuck upside down.",
		"Mr. Snuggles: *accepts his fate with dignity*",
	])

	await E.queue([
		"*Bulky Life Jacket: Works but slows raft travel*",
	])

	I.LifeJacketBulky.add()
	I.Oar.add()
	I.RaftPatch.add()
	_collect_bonus_items()


func execute_bizarre_solution() -> void:
	"""Bizarre solution: Mr. Snuggles tests buoyancy interactively."""
	state.jacket_crafted = true
	state.solution_used = "bizarre"

	GameState.solve_puzzle("life_jacket", GameState.Approach.BIZARRE)

	await E.queue([
		"Tank: MR. SNUGGLES! YOU decide!",
		"Pig: ...you want the deer to design his own life jacket?",
		"Tank: HE knows what feels GOOD!",
	])

	# Interactive testing
	await E.queue([
		"*Mr. Snuggles approaches the materials*",
		"Mr. Snuggles: *sniffs cloth approvingly*",
		"Mr. Snuggles: *pushes away extra driftwood*",
		"Mr. Snuggles: *uses hoof to indicate strap tightness*",
		"Pig: ...I'll be darned. He actually knows what he wants.",
	])

	await E.queue([
		"*Custom-fit Life Jacket: Mr. Snuggles seems very comfortable*",
		"*+10 Morale for respecting Mr. Snuggles' preferences*",
	])

	GameState.add_morale(10)
	I.LifeJacket.add()
	I.Oar.add()
	I.RaftPatch.add()
	I.ShellWhistle.add()  # Bonus for Bizarre path
	_collect_bonus_items()


func execute_fail_forward() -> void:
	"""Fail-forward: Jacket fails test, deer bobs comedically."""
	state.jacket_crafted = true
	state.solution_used = "fail_forward"
	state.jacket_failed_test = true

	await E.queue([
		"Tank: *haphazardly throws materials together*",
		"Tank: DONE! Put it on, Mr. Snuggles!",
		"Pig: Did you even test if it floats?",
		"Tank: IT HAS WOOD! WOOD FLOATS!",
	])

	# Test failure
	await E.queue([
		"*Mr. Snuggles wades into the water*",
		"*The jacket immediately rotates him upside down*",
		"Mr. Snuggles: *legs sticking up, completely calm*",
		"Tank: ...WHOOPS.",
		"Pig: *sigh* Let me fix it.",
	])

	await E.queue([
		"*Pig adjusts the balance*",
		"*Mr. Snuggles bobs upright, looking satisfied*",
		"*Patched Life Jacket: Works, but Pig is slightly annoyed*",
		"*-5 Morale*",
	])

	GameState.add_morale(-5)
	I.LifeJacket.add()
	I.Oar.add()
	_collect_bonus_items()


func _collect_bonus_items() -> void:
	"""Give standard items everyone gets."""
	if not state.collected_rope:
		state.collected_rope = true
		I.Rope.add()


func launch_raft() -> void:
	"""Launch sequence to start sea crossing."""
	if not state.jacket_crafted:
		await C.Tank.say("Mr. Snuggles needs a life jacket first!")
		return

	state.raft_launched = true

	await E.queue([
		"Tank: TIME TO SAIL!",
		"Pig: It's a raft, we're paddlin'.",
		"Tank: TIME TO PADDLE!",
	])

	# Launch sequence
	await E.queue([
		"*The party pushes off from the Brazilian shore*",
		"Mr. Snuggles: *floats comfortably in life jacket*",
		"Tank: GOODBYE BRAZIL! HELLO ADVENTURE!",
		"Pig: *checks route sketch*",
		"Pig: Puerto Rico first, then Florida, then... somehow... Canada.",
		"Tank: THE PLAN IS PERFECT!",
	])

	# Transition to sea room
	E.goto_room("CaribbeanRaft")


func take_shell_whistle() -> void:
	"""Optional shell whistle for fog navigation later."""
	if state.took_whistle:
		await C.Tank.say("I already have the whistle!")
		return

	state.took_whistle = true
	I.ShellWhistle.add()

	await E.queue([
		"Tank: *picks up conch shell*",
		"Tank: A BATTLE HORN!",
		"Tank: *HOOOONK*",
		"Pig: ...that's for emergencies only.",
		"*Gained: Shell Whistle (may be useful in fog)*",
	])
