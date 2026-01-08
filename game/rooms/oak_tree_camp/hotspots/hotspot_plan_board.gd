@tool
extends PopochiuHotspot
## Plan Board hotspot - Pig's route planning board

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Pig's planning board. Full of maps and notes.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I shouldn't mess with Pig's plans.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Pig's route planning board!")
	await C.player.say("Brazil to Canada... that's a long way!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I study the plan carefully.")
	await C.player.say("Lots of lines and arrows. Pig is smart!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello plan board! Show me the way to Canada!")
	await C.player.say("It points north. Very helpful!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I shouldn't take Pig's board.")
	await C.player.say("He needs it for planning!")


#endregion
