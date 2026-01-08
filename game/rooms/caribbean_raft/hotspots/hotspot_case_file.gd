@tool
extends PopochiuHotspot
## Case File hotspot - Information overlay for the crossing

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Pig's navigation notes.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("The notes don't need that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("These are Pig's travel notes!")
	await C.player.say("Full of maps and calculations. Very impressive!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I study the notes carefully.")
	await C.player.say("Still don't understand them, but I feel smarter!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello notes! Tell me your secrets!")
	await C.player.say("The notes remain silent but informative.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I should leave these for Pig.")
	await C.player.say("He's the navigator, not me!")


#endregion
