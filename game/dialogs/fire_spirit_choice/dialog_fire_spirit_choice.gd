@tool
extends PopochiuDialog
## Dialog for the Fire Spirit choice (BIZARRE solution in Tank Vision)
## Tank Vision interpretation of the exposed wiring + gas leak


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("The fire spirit dances before me...")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"free_spirit":
			await C.player.say("Fire spirit! Unite with the monster blood! Cleanse this place!")
			stop()
			await R.RoadMonsters.execute_bizarre_solution()

		"befriend_spirit":
			await C.player.say("Little fire spirit, are you friendly?")
			await C.player.say("It... it seems to be beckoning toward the leaking stuff.")
			_show_options()

		"leave_spirit":
			await C.player.say("I should leave the fire spirit alone.")
			stop()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
