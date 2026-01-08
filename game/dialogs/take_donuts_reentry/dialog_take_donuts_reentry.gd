@tool
extends PopochiuDialog
## Dialog for taking the donut box at re-entry site.


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("DONUTS!")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"take_them":
			await C.player.say("MINE!")
			stop()
			# Check if player already has DonutBox - if so, we're restocking
			if I.DonutBox.is_in_inventory():
				await C.player.say("MORE donuts! My collection grows!")
			else:
				I.DonutBox.queue_add()
				await C.player.say("Real Earth donuts! I missed you!")
			# Mark as taken
			var room = R.ReentryFire as PopochiuRoom
			room.state.donut_box_taken = true
			GameState.modify_morale(5)

		"leave_them":
			await C.player.say("No time for donuts right now!")
			await C.player.say("...")
			await C.player.say("I can't believe I just said that.")
			stop()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
