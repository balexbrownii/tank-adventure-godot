@tool
extends PopochiuHotspot
## Motel Desk hotspot - Check-in counter

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("The motel check-in desk.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("The clerk doesn't want that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The motel front desk!")
	await C.player.say("A bored-looking clerk sits behind it.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I ring the bell!")
	await C.player.say("DING! The clerk looks up wearily.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello! We need a room for the night!")
	await C.player.say("The clerk eyes Pig and Mr. Snuggles suspiciously.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a desk.")
	await C.player.say("The clerk would definitely notice!")


#endregion
