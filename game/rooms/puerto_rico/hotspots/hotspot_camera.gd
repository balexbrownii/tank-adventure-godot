@tool
extends PopochiuHotspot
## Camera hotspot - Security camera

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A security camera. Watching everything.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't block the camera with that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A security camera!")
	await C.player.say("We need to avoid being recorded...")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to disable the camera.")
	await C.player.say("It's too high up to reach!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello camera! Please don't see us!")
	await C.player.say("It swivels toward me. Not good!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't reach the camera!")
	await C.player.say("It's mounted too high!")


#endregion
