@tool
extends PopochiuDialog
## Dialog for taking the backpack.


#region Virtual ####################################################################################
func _on_start() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("Should I take the TREASURE SACK?")
	else:
		await C.player.say("Should I take my backpack?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"take_it":
			await E.queue([
				"Tank picks up the backpack",
				"Tank: Ready for adventure!"
			])
			I.Backpack.add_to_inventory()
			R.WantedCamp.state.backpack_taken = true
			stop()

		"leave_it":
			await C.player.say("I'll come back for it later.")
			stop()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
