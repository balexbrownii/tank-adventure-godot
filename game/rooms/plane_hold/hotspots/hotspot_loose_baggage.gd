@tool
extends PopochiuHotspot
## Loose Baggage hotspot - Suitcases sliding around

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Suitcases sliding around the cargo hold.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to add that to the sliding bags.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The suitcases are sliding everywhere!")
	await C.player.say("The turbulence is really bad!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to catch the sliding bags!")
	await C.player.say("Got one! It's heavy!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Stop sliding, suitcases!")
	await C.player.say("They don't listen. Rude suitcases.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab a sliding suitcase!")
	await C.player.say("Oof! Someone packed bricks in this one!")


#endregion
