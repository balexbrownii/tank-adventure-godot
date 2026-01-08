@tool
extends PopochiuHotspot
## Car hotspot - A parked car near the airport

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Someone's car. Looks nice.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I shouldn't mess with someone's car.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A fancy car in the parking lot!")
	await C.player.say("Pig says we should NOT steal this one.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try the door. Locked.")
	await C.player.say("Pig says that's for the best.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello car! Are you going to Texas?")
	await C.player.say("The car does not answer.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I could lift this car...")
	await C.player.say("But Pig says I shouldn't.")


#endregion
