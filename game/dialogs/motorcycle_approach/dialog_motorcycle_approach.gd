@tool
extends PopochiuDialog
## Main approach choice dialog for Motorcycle puzzle.
## Presents three approaches: Brains (controls), Brawn (punch), Bizarre (lever)


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("How do I start this metal horse?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"find_controls":
			# BRAINS solution - Find and use the proper controls
			await C.player.say("Let me figure out the controls...")
			stop()

			var room = R.ReentryFire as PopochiuRoom
			if room.state.motorcycle_examined_reality:
				# Already examined in reality mode
				await R.ReentryFire.execute_brains_solution()
			else:
				await C.player.say("Big red button... twist grip... kick lever...")
				await R.ReentryFire.execute_brains_solution()

		"punch_it":
			# BRAWN solution - Just punch the motorcycle
			await C.player.say("MACHINES UNDERSTAND FORCE!")
			stop()
			await R.ReentryFire.execute_brawn_solution()

		"use_lever":
			# BIZARRE solution - Use road sign arrow
			await C.player.say("I need to pry something loose...")
			stop()

			if I.RoadSignArrow.is_in_inventory():
				await R.ReentryFire.execute_bizarre_solution()
			else:
				await C.player.say("But I don't have anything to use as a lever...")
				await C.player.say("That road sign has an arrow on it...")
				_show_options()

		"just_kick":
			# Fail-forward option
			await C.player.say("I'll just... kick it really hard!")
			stop()
			await R.ReentryFire.execute_fail_forward()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
