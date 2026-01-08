@tool
extends PopochiuHotspot
## Airport Entrance hotspot - Main way into the airport

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("The main airport entrance. Lots of security.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't use that to get in.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The main entrance to the airport!")
	await C.player.say("Pig says there's too much security this way.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I start to walk in...")
	await C.player.say("A guard looks at me suspiciously. Maybe not.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello airport! Can we sneak through?")
	await C.player.say("The doors slide open ominously.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up an entrance.")
	await C.player.say("That's not how doors work!")


#endregion
