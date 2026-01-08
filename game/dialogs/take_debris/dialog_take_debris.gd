@tool
extends PopochiuDialog
## Dialog for picking up debris from the debris field.


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("Should I grab that shiny piece?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"take_it":
			await C.player.say("SPACE TREASURE! MINE!")
			stop()
			# Add debris to inventory
			I.DebrisTrinket.queue_add()
			# Mark as collected
			var room = R.SpaceDrift as PopochiuRoom
			room.state.debris_collected = true
			await C.player.say("I'm keeping this forever.")

		"leave_it":
			await C.player.say("Nah, I've got enough junk.")
			stop()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
