@tool
extends PopochiuHotspot
## Conveyor Belt hotspot - Moves luggage around

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A conveyor belt carrying suitcases.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I shouldn't put that on the belt.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The conveyor belt moves suitcases around!")
	await C.player.say("If we get in a suitcase, it'll take us to the plane!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I hop on the belt!")
	await C.player.say("Wheee! This is faster than walking!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello conveyor belt! Where do you go?")
	await C.player.say("It rumbles along, unconcerned.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a conveyor belt.")
	await C.player.say("It's... really long.")


#endregion
