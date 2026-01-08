@tool
extends PopochiuHotspot
## Tree Line hotspot - Trees around the airport

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Palm trees. Very Florida.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The trees don't need that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Florida palm trees!")
	await C.player.say("They look different from Brazil trees!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I shake a palm tree!")
	await C.player.say("A coconut falls. Ow!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello Florida trees!")
	await C.player.say("They sway in the breeze. Friendly!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a whole tree.")
	await C.player.say("Well, I probably could, but I shouldn't.")


#endregion
