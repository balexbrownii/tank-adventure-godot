@tool
extends PopochiuHotspot
## Starfield hotspot - Stars all around

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Stars everywhere! So pretty!")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("Stars are too far away for that!")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("So many stars! Billions of them!")
	await C.player.say("Space is REALLY big!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to swim toward a star!")
	await C.player.say("It doesn't get any closer...")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("HELLO STARS! I'M TANK!")
	await C.player.say("They twinkle back at me!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I reach for a star!")
	await C.player.say("...Still reaching... so far...")


#endregion
