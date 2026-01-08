@tool
extends PopochiuHotspot
## Room Door hotspot - Motel room entrance

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("The door to our motel room.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to use that on the door.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Our motel room door!")
	await C.player.say("Room 7. Lucky number!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I unlock the door with the key card.")
	await C.player.say("BEEP! Green light! We're in!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello room! Be comfortable for us!")
	await C.player.say("The door swings open welcomingly.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a door.")
	await C.player.say("It's attached to the wall!")


#endregion
