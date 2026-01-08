@tool
extends PopochiuRoom
## Room 8 - Re-entry Fire + Motorcycle Escape
## Tank re-enters atmosphere on fire, lands near the gas station,
## and must escape on a motorcycle before pursuit escalates.

const Data := preload('room_reentry_fire_state.gd')
var state: Data = load("res://game/rooms/reentry_fire/room_reentry_fire.tres")

## Vision data for hotspots in this room
var vision_data: Dictionary = {
	"landing_spot": {
		"tank_hover": "MY CRATER",
		"tank_inspect": "I made this! With my body! Still smoking.",
		"reality_hover": "Impact Site",
		"reality_inspect": "A small crater where you landed. Still smoldering."
	},
	"motorcycle": {
		"tank_hover": "METAL HORSE",
		"tank_inspect": "A wild metal horse! I must tame it!",
		"reality_hover": "Motorcycle",
		"reality_inspect": "A parked motorcycle. Keys might be nearby."
	},
	"road_sign": {
		"tank_hover": "DIRECTION TOTEM",
		"tank_inspect": "The ancient signs point... somewhere!",
		"reality_hover": "Road Sign",
		"reality_inspect": "A directional sign. The arrow could be removed..."
	},
	"donut_box": {
		"tank_hover": "SALVATION",
		"tank_inspect": "DONUTS! Real Earth donuts! I'm home!",
		"reality_hover": "Discarded Donut Box",
		"reality_inspect": "A box of donuts someone left behind. Still looks fresh."
	},
	"police_siren": {
		"tank_hover": "ANGRY LIGHTS",
		"tank_inspect": "The angry light monsters are coming closer!",
		"reality_hover": "Police Sirens (Distance)",
		"reality_inspect": "Police sirens in the distance. Getting closer."
	}
}


#region Virtual ####################################################################################
func _on_room_entered() -> void:
	# Register vision data for this room
	for hotspot_id in vision_data:
		TankVision.register_hotspot_data("ReentryFire", hotspot_id, vision_data[hotspot_id])


func _on_room_transition_finished() -> void:
	if not state.landing_complete:
		await _play_landing_sequence()
		state.landing_complete = true


#endregion

#region Public ####################################################################################

## Execute Brains solution: Identify motorcycle controls properly
func execute_brains_solution() -> void:
	state.solution_used = "brains"
	GameState.solve_puzzle("motorcycle_start", GameState.Approach.BRAINS)

	await E.queue([
		"Tank: Okay, let's see... big red button, twist grip, kick lever...",
		"Tank: This is just like the training videos!",
		"Tank: ...I've never watched training videos.",
		"Tank presses the button, twists the grip, and kicks the lever",
		"The motorcycle roars to life",
		"Tank: I'M A NATURAL!"
	])

	await _escape_sequence()


## Execute Brawn solution: Punch-start the motorcycle
func execute_brawn_solution() -> void:
	state.solution_used = "brawn"
	GameState.solve_puzzle("motorcycle_start", GameState.Approach.BRAWN)
	GameState.modify_heat(1)

	await E.queue([
		"Tank: Machines understand one thing: FORCE!",
		"Tank winds up a powerful punch",
		"WHAM!",
		"The motorcycle sputters... then roars to life",
		"Something falls off the motorcycle",
		"Tank: GOOD ENOUGH!"
	])

	# Lose a potential item due to damage
	await _escape_sequence()


## Execute Bizarre solution: Use road sign arrow as lever
func execute_bizarre_solution() -> void:
	state.solution_used = "bizarre"
	GameState.solve_puzzle("motorcycle_start", GameState.Approach.BIZARRE)

	await E.queue([
		"Tank: This metal horse is stuck!",
		"Tank: I need... a lever!",
		"Tank jams the road sign arrow into the motorcycle's controls",
		"With a creative twist...",
		"The motorcycle lurches to life in a way it probably shouldn't",
		"Tank: ENGINEERING!"
	])

	# Remove the arrow since it's now part of the motorcycle
	if I.RoadSignArrow.is_in_inventory():
		I.RoadSignArrow.queue_remove()

	await _escape_sequence()


## Fail-forward: Crash into plushie pile
func execute_fail_forward() -> void:
	state.crashed_into_plushies = true
	GameState.modify_morale(-5)

	await E.queue([
		"Tank kicks the motorcycle wildly",
		"The motorcycle shoots forward",
		"Tank: WAIT I'M NOT REA-",
		"CRASH!",
		"Tank lands in a pile of promotional plushies",
		"Tank: ...",
		"Tank: These are surprisingly comfortable.",
		"A plushie is now stuck to Tank's back"
	])

	# Give the cosmetic plushie item
	I.PlushStuck.queue_add()

	await _escape_sequence_slow()


#endregion

#region Private ####################################################################################

func _play_landing_sequence() -> void:
	await E.queue([
		"Tank plummets through the atmosphere",
		"Tank: STILL ON FIRE! STILL ON FIRE!",
		"...",
		"THUD",
		"Tank creates a small crater near the gas station ruins",
		"Tank: Ow.",
		"Tank pats out the remaining flames",
		"Tank: At least I'm not in space anymore."
	])

	# Different follow-up based on inventory from space
	if I.SpaceSoot.is_in_inventory():
		await E.queue([
			"Tank: I'm covered in space soot. Cool.",
			"Tank: Wait... do I smell donuts?!"
		])
	else:
		await E.queue([
			"Tank: That was... an experience.",
			"Tank: Now where am I?"
		])

	# Police sirens start
	await E.queue([
		"Distant sirens begin wailing",
		"Tank: Uh oh. The backup monsters are coming!",
		"Tank: I need to GET OUT OF HERE!"
	])


func _escape_sequence() -> void:
	await E.queue([
		"Tank hops on the motorcycle",
		"Tank: Time to ride!",
		"The motorcycle roars down the road",
		"Sirens fade behind Tank",
		"Tank: FREEDOM!"
	])

	# Transition to next room
	E.goto_room("PigDeerCrossing")


func _escape_sequence_slow() -> void:
	await E.queue([
		"Tank awkwardly climbs back on the motorcycle",
		"With a plushie stuck to her back",
		"Tank: Let's try this again...",
		"The motorcycle slowly putters away",
		"Tank: This is fine. This is fine."
	])

	# Transition to next room
	E.goto_room("PigDeerCrossing")


#endregion
