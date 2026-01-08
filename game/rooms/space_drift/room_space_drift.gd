@tool
extends PopochiuRoom
## Room 7 - Space Drift
## Tank has been launched into space by the gas station explosion.
## She must navigate back to Earth using absurd logic.

const Data := preload('room_space_drift_state.gd')
var state: Data = load("res://game/rooms/space_drift/room_space_drift.tres")

## Vision data for hotspots in this room
var vision_data: Dictionary = {
	"earth": {
		"tank_hover": "THE BLUE MARBLE",
		"tank_inspect": "That's home! I can smell the donuts from here!",
		"reality_hover": "Earth",
		"reality_inspect": "Our planet. You need to get back there."
	},
	"starfield": {
		"tank_hover": "SPARKLY DARKNESS",
		"tank_inspect": "So many tiny suns! Are they cheering for me?",
		"reality_hover": "Stars",
		"reality_inspect": "Stars. They could help with navigation if you knew constellations."
	},
	"floating_debris": {
		"tank_hover": "SPACE TREASURE",
		"tank_inspect": "Ooh, shiny things floating! Maybe one is a snack?",
		"reality_hover": "Debris Field",
		"reality_inspect": "Assorted space junk. Some might be useful, some might be dangerous."
	},
	"donut_scent_trail": {
		"tank_hover": "DONUT COMPASS",
		"tank_inspect": "I can SMELL donuts! They're calling me home!",
		"reality_hover": "Faint Trail",
		"reality_inspect": "Some kind of particle trail. Probably from the explosion debris."
	},
	"case_file_overlay": {
		"tank_hover": "WORDS FLOATING",
		"tank_inspect": "Why is there a science book up here?!",
		"reality_hover": "Science Lesson Overlay",
		"reality_inspect": "An interactive explanation of gravity. Drag arrows to orient yourself."
	}
}


#region Virtual ####################################################################################
func _on_room_entered() -> void:
	# Register vision data for this room
	for hotspot_id in vision_data:
		TankVision.register_hotspot_data("SpaceDrift", hotspot_id, vision_data[hotspot_id])


func _on_room_transition_finished() -> void:
	if state.solution_used == "":
		# First time in space - intro sequence
		await E.queue([
			"Tank tumbles through the void, still smoking from the explosion",
			"...",
			"C.player.queue_face_right()",
			"Tank: ...",
			"Tank: ...",
			"Tank: I'M IN SPAAAAACE!",
			"Tank looks around with a mix of awe and confusion",
			"Tank: Okay. Okay okay okay. I've trained for this.",
			"Tank: I have NOT trained for this.",
			"...",
			"Tank spots Earth in the distance"
		])

		# Different reaction based on inventory from Room 6
		if I.DonutBox.is_in_inventory():
			await E.queue([
				"Tank: Wait... I still have my donuts!",
				"Tank: And they smell like... HOME!",
				"Tank: That's it! I'll follow the donut smell back to Earth!"
			])
			state.donut_trail_found = true
		elif I.Helmet.is_in_inventory():
			await E.queue([
				"Tank: Good thing I grabbed this helmet.",
				"Tank: Though I'm not sure how it's helping me breathe...",
				"Tank: Best not to think about that."
			])
		else:
			await E.queue([
				"Tank: No helmet, no donuts...",
				"Tank: Just me and the cold embrace of space.",
				"Tank: PERFECT."
			])


#endregion

#region Public ####################################################################################

## Execute Brawn solution: Follow donut smell with swim strokes
func execute_brawn_solution() -> void:
	state.solution_used = "brawn"
	GameState.solve_puzzle("space_drift_main", GameState.Approach.BRAWN)

	await E.queue([
		"Tank: Alright, donut compass... don't fail me now!",
		"Tank takes a deep sniff",
		"Tank: I SMELL YOU, EARTH DONUTS!",
		"Tank begins 'swimming' through space with determined strokes"
	])

	# Swim rhythm sequence
	await _swim_rhythm_sequence()


## Execute Brains solution: Use Case File gravity puzzle
func execute_brains_solution() -> void:
	state.solution_used = "brains"
	GameState.solve_puzzle("space_drift_main", GameState.Approach.BRAINS)

	await E.queue([
		"Tank: According to this science thingy...",
		"Tank: If I point the 'down' arrow at Earth...",
		"Tank: Then gravity will know where to pull me!",
		"Tank: That's how science works, right?"
	])

	# Panel puzzle was already solved via PanelManager
	await _gravity_descent_sequence()


## Execute Bizarre solution: Drop item to increase speed
func execute_bizarre_solution() -> void:
	state.solution_used = "bizarre"
	GameState.solve_puzzle("space_drift_main", GameState.Approach.BIZARRE)

	# Find a non-essential item to drop
	var dropped_item = _find_droppable_item()

	if dropped_item:
		await E.queue([
			"Tank: I remember something about 'for every action'...",
			"Tank: If I THROW something...",
			"Tank: I'll go the OTHER way!",
			"Tank: PHYSICS!",
			"Tank hurls the %s into the void" % dropped_item,
			"Tank rockets toward Earth at alarming speed"
		])
		# Actually remove the item
		_drop_item(dropped_item)
	else:
		# No item to drop - use body momentum instead
		await E.queue([
			"Tank: I don't have anything to throw...",
			"Tank: Wait! I'll throw my ENTHUSIASM!",
			"Tank performs a ridiculous spin-punch combo",
			"Somehow, this works"
		])

	await _fast_descent_sequence()


## Fail-forward: Tank spins like rotisserie chicken but eventually drifts home
func execute_fail_forward() -> void:
	state.is_spinning = true
	GameState.modify_morale(-5)

	await E.queue([
		"Tank flails wildly",
		"Tank: SWIMMING! I'M SWIMMING!",
		"Tank begins spinning like a rotisserie chicken",
		"Tank: THIS IS NOT SWIMMING!",
		"...",
		"Tank: Wheeeeeee!",
		"...",
		"Despite everything, Tank slowly drifts toward Earth",
		"Tank: I meant to do that!"
	])

	# Still transitions to next room, just with lower morale
	await _slow_drift_sequence()


#endregion

#region Private ####################################################################################

func _swim_rhythm_sequence() -> void:
	# In a full implementation, this would be a rhythm minigame
	# For now, simulate the sequence
	await E.queue([
		"Tank: Stroke! Stroke! Stroke! Stroke!",
		"Tank 'swims' through space with surprising grace",
		"The donut smell grows stronger",
		"Tank: I SEE THE ATMOSPHERE! And it looks... burny."
	])

	# Add Space Soot to inventory
	I.SpaceSoot.queue_add()

	# Transition to next room
	await _transition_to_reentry()


func _gravity_descent_sequence() -> void:
	await E.queue([
		"The arrows align perfectly",
		"Tank feels a gentle tug toward Earth",
		"Tank: It's working! Science is working!",
		"Tank descends in a controlled, dignified manner",
		"Tank: This is way less exciting than I expected."
	])

	# Add Space Soot to inventory
	I.SpaceSoot.queue_add()

	# Transition to next room
	await _transition_to_reentry()


func _fast_descent_sequence() -> void:
	await E.queue([
		"Tank plummets toward Earth at LUDICROUS SPEED",
		"Tank: WOOOOOOOOOO!",
		"Tank: Wait, is this TOO fast?!",
		"Tank: NAH!",
		"Earth grows rapidly larger"
	])

	# No time to collect Space Soot when going this fast

	# Transition to next room
	await _transition_to_reentry()


func _slow_drift_sequence() -> void:
	await E.queue([
		"Tank continues spinning, but slowly drifting Earthward",
		"Several awkward minutes pass",
		"Tank: Are we there yet?",
		"More spinning",
		"Tank: How about now?",
		"Eventually, Earth's gravity takes over"
	])

	# Collect Space Soot since there's plenty of time
	I.SpaceSoot.queue_add()

	# Transition to next room
	await _transition_to_reentry()


func _transition_to_reentry() -> void:
	await E.queue([
		"Tank hits the atmosphere",
		"Tank: Uh oh. It's getting warm.",
		"Tank: VERY warm.",
		"Tank: I'M ON FIRE AGAIN!"
	])

	# Go to Room 8 - Re-entry Fire
	E.goto_room("ReentryFire")


func _find_droppable_item() -> String:
	# Check for non-essential items that can be dropped
	# Priority: MapFlyer > Cone > DonutBox (keep Helmet if possible)
	if I.MapFlyer.is_in_inventory():
		return "MapFlyer"
	elif I.Cone.is_in_inventory():
		return "Cone"
	elif I.DonutBox.is_in_inventory():
		return "DonutBox"
	return ""


func _drop_item(item_name: String) -> void:
	match item_name:
		"MapFlyer":
			I.MapFlyer.queue_remove()
		"Cone":
			I.Cone.queue_remove()
		"DonutBox":
			I.DonutBox.queue_remove()


#endregion
