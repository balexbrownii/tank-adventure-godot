@tool
extends PopochiuDialog
## Dialog for taking the arrow from the road sign.


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("Should I take this arrow?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"take_it":
			await C.player.say("YOINK!")
			stop()
			# Add arrow to inventory
			I.RoadSignArrow.queue_add()
			# Mark as taken
			var room = R.ReentryFire as PopochiuRoom
			room.state.sign_arrow_taken = true
			await C.player.say("Got it! This could be useful.")

		"leave_it":
			await C.player.say("I'll leave the sign alone.")
			await C.player.say("It's directing someone, probably.")
			stop()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
