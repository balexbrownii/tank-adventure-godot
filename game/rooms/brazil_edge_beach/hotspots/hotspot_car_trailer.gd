@tool
extends PopochiuHotspot
## Car Trailer hotspot - The stolen trailer/car

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Our trusty ride... well, borrowed ride.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to put that in the trailer.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The car that got us here!")
	await C.player.say("It can't cross the ocean though. Too bad.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I pat the hood. Good car!")
	await C.player.say("Thanks for the ride!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Thank you, metal friend! You served us well!")
	await C.player.say("The car does not respond. Because it's a car.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I could probably lift it...")
	await C.player.say("But where would I put it?")


#endregion
