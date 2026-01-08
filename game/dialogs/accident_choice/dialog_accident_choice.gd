@tool
extends PopochiuDialog
## Dialog for the Accident choice (BIZARRE solution in Reality Vision)
## Reality Vision interpretation of the exposed wiring + gas leak


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("This exposed wiring near the gas leak... that's really dangerous.")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"cause_accident":
			await C.player.say("If I just... nudge this wire toward the leak...")
			await C.player.say("...purely by accident, of course...")
			stop()
			await R.RoadMonsters.execute_bizarre_solution()

		"prevent_accident":
			await C.player.say("I should try to prevent this from causing a fire!")
			stop()
			await R.RoadMonsters.execute_fail_forward()

		"leave_alone":
			await C.player.say("I'll leave this alone. Too dangerous.")
			stop()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
