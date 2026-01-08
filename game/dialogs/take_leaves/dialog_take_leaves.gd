@tool
extends PopochiuDialog
## Dialog: Take Leaves
## Simple pickup dialog for the leaf pile


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("Should I gather these leaves?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"take":
			await C.player.say("*gathers armful of leaves*")
			await C.player.say("These will make a cozy blanket!")
			await R.DitchHideout.take_leaf_pile()
			stop()

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
