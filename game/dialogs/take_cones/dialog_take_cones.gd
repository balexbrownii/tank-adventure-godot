@tool
extends PopochiuDialog
## Dialog for picking up traffic cones


#region Virtual ####################################################################################
func _on_start() -> void:
	await PopochiuUtils.e.get_tree().process_frame


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"take_cones":
			await C.player.say("I'll take these warning totems!")
			stop()
			I.Cone.add()

		"use_here":
			await C.player.say("I'll use them right here to redirect the monsters!")
			stop()
			await R.RoadMonsters.execute_brains_solution()

		"leave":
			await C.player.say("I'll leave them for now.")
			stop()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
