@tool
extends PopochiuDialog
## Dialog for taking the vine.


#region Virtual ####################################################################################
func _on_start() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("Should I take the NATURE ROPE?")
	else:
		await C.player.say("Should I take some vine?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"take_it":
			await E.queue([
				"Tank coils up some vine",
				"Tank: This could come in handy!"
			])
			I.Vine.add_to_inventory()
			R.WantedCamp.state.vine_taken = true
			stop()

		"leave_it":
			await C.player.say("I'll leave it for now.")
			stop()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
