@tool
extends PopochiuHotspot
## Case File Overlay hotspot - Interactive "science lesson" that enables Brains solution.
## Uses PanelManager for the gravity arrow puzzle.

const PUZZLE_ID := "space_gravity_arrows"

#region Virtual ####################################################################################
func _on_room_entered() -> void:
	# Register the panel puzzle for this room
	_setup_gravity_puzzle()


func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.solution_used != "":
		await C.player.say("I already figured out the gravity thing!")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await _tank_vision_interaction()
	else:
		await _reality_vision_interaction()

	room.state.case_file_examined = true


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["case_file_overlay"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't think I can put that in the science book.")


#endregion

#region Private ####################################################################################
func _setup_gravity_puzzle() -> void:
	# Register with PanelManager
	PanelManager.register_puzzle(PUZZLE_ID, 4)

	# Add valid solution - panels must be in order: [3, 0, 1, 2]
	# This represents rotating the arrows so "down" points to Earth
	var solution: Array[int] = [3, 0, 1, 2]
	PanelManager.add_solution(PUZZLE_ID, solution)

	# Add configuration for solved state
	PanelManager.add_configuration(PUZZLE_ID, solution, {
		"effect": "gravity_aligned"
	}, ["space_gravity_solved"])

	# Add narrator messages
	PanelManager.add_narrator_messages(PUZZLE_ID, {
		"protest": "That's not how gravity works!",
		"confusion": "Wait, did you just... rotate physics?",
		"acceptance": "Fine. 'Down' is whatever you say it is.",
		"impressed": "Huh. The arrows actually lined up. Science!"
	})


func _tank_vision_interaction() -> void:
	await C.player.say("WORDS FLOATING IN SPACE!")
	await C.player.say("Is this a test?! Am I being GRADED?!")
	await C.player.say("I didn't study!")

	# Still allow interaction with puzzle
	await D.GravityPuzzleIntro.start()


func _reality_vision_interaction() -> void:
	await C.player.say("An interactive science lesson. About gravity.")
	await C.player.say("It says I can drag the arrows to point 'down' toward my destination...")
	await C.player.say("If I point all the arrows at Earth, maybe gravity will know where to pull me?")

	# Start the puzzle
	await D.GravityPuzzleIntro.start()


#endregion
