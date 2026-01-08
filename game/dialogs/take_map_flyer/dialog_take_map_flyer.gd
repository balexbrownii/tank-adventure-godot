@tool
extends PopochiuDialog
## Dialog for taking the map flyer from gas station


#region Virtual ####################################################################################
func _on_start() -> void:
	await PopochiuUtils.e.get_tree().process_frame


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"take_flyer":
			await C.player.say("This might be useful.")
			stop()
			I.MapFlyer.add()
			R.RoadMonsters.state.items_collected.append("map_flyer")

		"leave":
			await C.player.say("I don't need a map.")
			stop()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
