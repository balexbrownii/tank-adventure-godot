@tool
extends PopochiuDialog
## Main approach choice dialog for Space Drift puzzle.
## Presents three approaches: Brawn (swim with donut compass), Brains (gravity puzzle), Bizarre (drop item)


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("I need to get back to Earth... but how?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"follow_donut_smell":
			# BRAWN solution - Swim toward donut smell
			await C.player.say("I'll follow the donut smell! My nose knows the way!")
			stop()
			await R.SpaceDrift.execute_brawn_solution()

		"use_science":
			# BRAINS solution - Use the gravity puzzle
			await C.player.say("Maybe that science thingy can help...")
			stop()
			# Check if puzzle is already solved
			if PanelManager.is_puzzle_solved("space_gravity_arrows"):
				await R.SpaceDrift.execute_brains_solution()
			else:
				await C.player.say("I need to figure out the gravity arrows first.")
				# Player needs to interact with case file overlay

		"throw_something":
			# BIZARRE solution - Drop item for thrust
			await C.player.say("What if I throw something?!")
			stop()
			# Check if player has something to throw
			var droppable = _find_droppable()
			if droppable != "":
				await R.SpaceDrift.execute_bizarre_solution()
			else:
				await C.player.say("I don't have anything I'm willing to throw away...")
				_show_options()

		"just_float":
			# Fail-forward option
			await C.player.say("Maybe I should just... float?")
			await C.player.say("...")
			await C.player.say("This isn't working.")
			stop()
			# Eventually leads to fail-forward
			await R.SpaceDrift.execute_fail_forward()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion

#region Private ####################################################################################
func _find_droppable() -> String:
	if I.MapFlyer.is_in_inventory():
		return "MapFlyer"
	elif I.Cone.is_in_inventory():
		return "Cone"
	elif I.DonutBox.is_in_inventory():
		return "DonutBox"
	return ""


#endregion
