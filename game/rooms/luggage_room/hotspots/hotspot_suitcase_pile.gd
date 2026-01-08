@tool
extends PopochiuHotspot
## Suitcase Pile hotspot - Mountains of luggage

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Lots of suitcases waiting to be loaded.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to add that to the pile.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("So many suitcases!")
	await C.player.say("One of these must be going to Texas!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I check the tags on the suitcases.")
	await C.player.say("New York... Miami... Need to find Texas!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello suitcases! Any of you going to Texas?")
	await C.player.say("They don't answer. Typical suitcases.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab a random suitcase.")
	await C.player.say("Ooh, heavy! Someone packed a lot!")


#endregion
