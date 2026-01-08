@tool
extends PopochiuDialog
## Dialog for taking a thorn from the bush.


#region Virtual ####################################################################################
func _on_start() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("Should I take a pointy from the ANGRY PLANT?")
	else:
		await C.player.say("Should I take a thorn?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"take_it":
			await E.queue([
				"Tank carefully plucks a large thorn",
				"Tank: OW! Worth it!",
				"Tank: This is a good pointy."
			])
			I.Thorn.add_to_inventory()
			R.WerewolfChase.state.thorn_taken = true
			stop()

		"leave_it":
			await C.player.say("Too pointy for me!")
			stop()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
