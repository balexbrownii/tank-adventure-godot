@tool
extends PopochiuHotspot
## Road Sign hotspot - Shows directions

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A road sign with directions.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't use that on the sign.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A road sign!")
	await C.player.say("It points toward... Canada! Wait, no... Brazil?")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I spin the sign around!")
	await C.player.say("Now Canada is that way! Problem solved!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Which way to Canada, sign?")
	await C.player.say("It points firmly in one direction.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I yank the sign out of the ground!")
	await C.player.say("Might be useful for navigation!")


#endregion
