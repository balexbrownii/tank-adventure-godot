@tool
extends PopochiuHotspot
## Moon hotspot - The moon guiding the way

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("The moon. A friendly light in the darkness.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The moon is too far away for that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The moon is beautiful tonight!")
	await C.player.say("Pig says we can use it to navigate. Smart!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I use the moon to figure out which way is north!")
	await C.player.say("Or was it south? Pig handles navigation.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello moon! Thanks for the light!")
	await C.player.say("The moon continues to glow silently.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I reach for the moon!")
	await C.player.say("It's... further than it looks.")


#endregion
