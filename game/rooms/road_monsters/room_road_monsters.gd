@tool
extends PopochiuRoom
## Room 6: Road of Monsters + Gas Station
## Tank sees cars as monsters, tries to save citizens, chaos ensues,
## gas station explodes, launches Tank into space.

const Data := preload('room_road_monsters_state.gd')

var state: Data = load("res://game/rooms/road_monsters/room_road_monsters.tres")

## Vision data for hotspots in this room
var vision_data: Dictionary = {
	"passing_cars": {
		"tank_hover": "MONSTERS",
		"tank_inspect": "Giant roaring monsters are swallowing people whole! I must save them!",
		"reality_hover": "Passing Cars",
		"reality_inspect": "Regular cars driving on the highway. The people inside seem fine."
	},
	"gas_truck": {
		"tank_hover": "MOTHER MONSTER",
		"tank_inspect": "The biggest monster of all! It must be the queen!",
		"reality_hover": "Gas Truck",
		"reality_inspect": "A fuel delivery truck. The pump connection looks... loose."
	},
	"police_car": {
		"tank_hover": "MONSTERS CALLING BACKUP",
		"tank_inspect": "More monsters are coming! They have flashing eyes!",
		"reality_hover": "Police Car",
		"reality_inspect": "Law enforcement responding to reports of a woman lifting cars."
	},
	"donut_sign": {
		"tank_hover": "SACRED RING",
		"tank_inspect": "A glowing ring of power! It calls to me!",
		"reality_hover": "Donut Display Sign",
		"reality_inspect": "Fresh donuts available inside. The smell is incredible."
	},
	"gas_station": {
		"tank_hover": "MONSTER LAIR",
		"tank_inspect": "The monsters return to this building to rest! A strategic target!",
		"reality_hover": "Gas Station",
		"reality_inspect": "PitStop Express. Looks like a normal gas station. Map flyers by the door."
	},
	"traffic_cones": {
		"tank_hover": "WARNING TOTEMS",
		"tank_inspect": "Ancient warnings placed by survivors! Heed them!",
		"reality_hover": "Traffic Cones",
		"reality_inspect": "Orange safety cones. Could redirect traffic if placed differently."
	},
	"leaking_pump": {
		"tank_hover": "MONSTER BLOOD",
		"tank_inspect": "The monster's lair is bleeding! Victory is near!",
		"reality_hover": "Leaking Gas Pump",
		"reality_inspect": "Gasoline is leaking from this pump. Very dangerous near sparks."
	},
	"spark_source": {
		"tank_hover": "TINY FIRE SPIRIT",
		"tank_inspect": "A small spirit made of light! Friendly?",
		"reality_hover": "Exposed Wiring",
		"reality_inspect": "Exposed electrical wiring. One spark and this whole place could..."
	}
}


#region Virtual ####################################################################################
func _on_room_entered() -> void:
	# Register vision data for all hotspots
	for hotspot_id in vision_data:
		TankVision.register_hotspot_data(script_name, hotspot_id, vision_data[hotspot_id])


func _on_room_transition_finished() -> void:
	if state.solution_used == "":
		# First time entering - Tank sees the "monsters"
		await E.queue([
			C.player.queue_face_right(),
			"Tank: What... what ARE those things?!",
			"Tank stares at the highway with growing alarm",
			"Tank: MONSTERS! They're eating people!"
		])

		# Check if we should show vision toggle hint
		if not GameState.has_flag("VISION_TOGGLE_LEARNED"):
			await E.queue([
				"(Press TAB to toggle Tank Vision / Reality Vision)"
			])


func _on_room_exited() -> void:
	pass


#endregion

#region Puzzle Solutions ###########################################################################

## BRAWN solution: Tank lifts a car to "save" the citizen
func execute_brawn_solution() -> void:
	if state.solution_used != "":
		return

	state.solution_used = "brawn"
	GameState.modify_heat(2)
	GameState.solve_puzzle("road_monsters_main", GameState.Approach.BRAWN)

	await E.queue([
		"Tank: Don't worry citizen! I'll save you!",
		"Tank approaches a stopped car at the gas station",
		"Tank: HYAAAH!",
		"Tank lifts the entire car over her head",
		"The driver screams in confusion",
		"A bystander calls 911",
	])

	# Police arrive faster with this solution
	state.police_arrived = true
	await _police_arrival_sequence()

	# Gain helmet from police car
	if not "helmet" in state.items_collected:
		state.items_collected.append("helmet")
		await E.queue([
			"In the chaos, Tank spots a helmet in the police car",
			"Tank: Protection! Smart!",
			I.Helmet.queue_add()
		])

	# Trigger inevitable explosion
	await _trigger_explosion()


## BRAINS solution: Redirect traffic away using cones
func execute_brains_solution() -> void:
	if state.solution_used != "":
		return

	state.solution_used = "brains"
	GameState.solve_puzzle("road_monsters_main", GameState.Approach.BRAINS)
	# No heat increase for smart solution

	await E.queue([
		"Tank: I need to warn people about the monster nest!",
		"Tank arranges the traffic cones in a new pattern",
		"Cars begin to divert around the gas station",
		"Tank: The monsters are confused! They can't find their victims!"
	])

	# Gain donut box (more time to grab it)
	if not "donut_box" in state.items_collected:
		state.items_collected.append("donut_box")
		await E.queue([
			"With the chaos temporarily averted, Tank notices the donut sign",
			"Tank: The sacred rings! I must have them!",
			"Tank grabs a box of donuts",
			I.DonutBox.queue_add()
		])

	# Explosion still happens, just delayed
	await E.queue([
		"But wait... a spark from the exposed wiring...",
		"Tank: Uh oh."
	])
	await _trigger_explosion()


## BIZARRE solution: Spot the leak + spark, "accidentally" cause explosion
func execute_bizarre_solution() -> void:
	if state.solution_used != "":
		return

	state.solution_used = "bizarre"
	GameState.modify_heat(1)
	GameState.solve_puzzle("road_monsters_main", GameState.Approach.BIZARRE)

	await E.queue([
		"Tank notices the leaking pump and exposed wiring"
	])

	if TankVision.current_mode == TankVision.VisionMode.REALITY:
		await E.queue([
			"Tank: Wait, that's gasoline and exposed wiring.",
			"Tank: If I just... nudge this wire...",
			"Tank 'accidentally' kicks the wire toward the leak"
		])
	else:
		await E.queue([
			"Tank: The monster's blood... and a tiny fire spirit...",
			"Tank: Fire spirit! Unite with the monster blood! Cleanse this place!",
			"Tank kicks the wire toward the leak with ceremonial flair"
		])

	# Gain map flyer (grabbed it while examining)
	if not "map_flyer" in state.items_collected:
		state.items_collected.append("map_flyer")
		await E.queue([
			"Tank had grabbed a map flyer while examining the station",
			I.MapFlyer.queue_add()
		])

	await _trigger_explosion()


## Fail-forward: Player tries to prevent explosion
func execute_fail_forward() -> void:
	if state.fail_forward_triggered:
		return

	state.fail_forward_triggered = true

	await E.queue([
		"Tank: I should stop that fire spirit from...",
		"Tank tries to cover the exposed wiring",
		"SUCCESS! The wire is covered!",
		"Tank: Ha! Destiny averted!"
	])

	await E.queue([
		"...",
		"Tank absently tosses a rock",
		"The rock hits a different electrical box",
		"SPARK"
	])

	await _trigger_explosion()


#endregion

#region Private ####################################################################################

func _police_arrival_sequence() -> void:
	await E.queue([
		"WEEE-OOOO WEEE-OOOO",
		"A police car screeches to a halt"
	])

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await E.queue([
			"Tank: More monsters! With flashing eyes!"
		])
	else:
		await E.queue([
			"Tank: Oh wait, those are police.",
			"Tank: ...I should probably run."
		])


func _trigger_explosion() -> void:
	if state.explosion_triggered:
		return

	state.explosion_triggered = true

	await E.queue([
		"The spark meets the gasoline",
		"Time seems to slow...",
		"BOOOOOOOOOM!",
		"The gas station erupts in a massive fireball",
		"Tank is launched into the air",
		"Tank: WHEEEEEEE!",
		"Higher...",
		"Higher...",
		"Past the clouds...",
		"Past the atmosphere...",
		"Tank: ...huh."
	])

	# Set flag for space room
	GameState.set_flag("LAUNCHED_TO_SPACE")

	# Transition to space room
	await E.goto_room("SpaceDrift")


#endregion
