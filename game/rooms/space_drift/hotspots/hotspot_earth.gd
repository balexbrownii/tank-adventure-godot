@tool
extends PopochiuHotspot
## Earth hotspot - View of Earth from space

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Earth! It's so... blue!")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't use that on Earth!")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("EARTH! My home!")
	await C.player.say("It looks so small from up here!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I reach toward Earth!")
	await C.player.say("Still too far away... Need to get closer!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I'M COMING HOME, EARTH!")
	await C.player.say("Earth spins peacefully, unaware.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to grab Earth!")
	await C.player.say("It's... it's really far away!")


#endregion
