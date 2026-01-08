@tool
extends PopochiuHotspot
## Instruction Card hotspot - Safety instructions

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Safety instruction card.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to use that with the card.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Safety instructions!")
	await C.player.say("Lots of pictures of people doing things calmly.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I study the safety card carefully.")
	await C.player.say("Put head down, grab ankles... got it!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("What should I do, little card people?")
	await C.player.say("They demonstrate crash positions calmly.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab the safety card.")
	await C.player.say("Important information to have right now!")


#endregion
