@tool
extends PopochiuHotspot
## Rock Marker hotspot - A landmark rock

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A big rock. Good for marking your location.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to use that on the rock.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A distinctive rock!")
	await C.player.say("I can use this to remember where I slept!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I pat the rock.")
	await C.player.say("Solid! You're a good rock!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello rock! Thanks for being a landmark!")
	await C.player.say("The rock is stoic and dependable.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I could lift this rock...")
	await C.player.say("But it's good where it is!")


#endregion
