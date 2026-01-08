@tool
extends PopochiuDialog
## Dialog: Take Roots
## Simple pickup dialog for the loose roots


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("These roots look useful. Pull some off?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"take":
			await C.player.say("*tugs on roots*")
			await C.player.say("Strong and fibrous! Good for tying things!")
			await R.DitchHideout.take_root_fiber()
			stop()

		"leave":
			await C.player.say("I'll leave them attached for now.")
			stop()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
