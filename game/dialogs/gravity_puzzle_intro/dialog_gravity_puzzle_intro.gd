@tool
extends PopochiuDialog
## Dialog introducing the gravity arrow panel puzzle.


const PUZZLE_ID := "space_gravity_arrows"

#region Virtual ####################################################################################
func _on_start() -> void:
	if PanelManager.is_puzzle_solved(PUZZLE_ID):
		await C.player.say("I already figured out the gravity thing!")
		stop()
		return

	await C.player.say("This science thing says I need to point arrows at Earth...")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"try_puzzle":
			await C.player.say("Okay, let's see... drag arrows... point down...")
			stop()
			# In a full implementation, this would open an interactive UI
			# For now, we simulate solving it
			await _simulate_puzzle()

		"rotate_left":
			await C.player.say("Let me try rotating left...")
			stop()
			PanelManager.set_active_puzzle(PUZZLE_ID)
			PanelManager.move_panel(0, 3)
			if PanelManager.is_puzzle_solved(PUZZLE_ID):
				await C.player.say("The arrows are all pointing at Earth!")
				await R.SpaceDrift.execute_brains_solution()
			else:
				await C.player.say("Not quite right yet...")
				_show_options()

		"rotate_right":
			await C.player.say("Maybe rotate right?")
			stop()
			PanelManager.set_active_puzzle(PUZZLE_ID)
			PanelManager.move_panel(3, 0)
			if PanelManager.is_puzzle_solved(PUZZLE_ID):
				await C.player.say("The arrows are all pointing at Earth!")
				await R.SpaceDrift.execute_brains_solution()
			else:
				await C.player.say("Still not right...")
				_show_options()

		"give_up":
			await C.player.say("This science stuff is too hard!")
			stop()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion

#region Private ####################################################################################
func _simulate_puzzle() -> void:
	# Simulate player solving the puzzle after some attempts
	PanelManager.set_active_puzzle(PUZZLE_ID)

	# Show the puzzle interaction
	await C.player.say("Hmm... this arrow goes here...")
	await C.player.say("And this one...")

	# Solve it
	var solution: Array[int] = [3, 0, 1, 2]
	PanelManager.set_order(PUZZLE_ID, solution)

	await C.player.say("I DID IT! All the arrows point at Earth!")
	await C.player.say("Take THAT, science!")

	# Execute the brains solution
	await R.SpaceDrift.execute_brains_solution()


#endregion
