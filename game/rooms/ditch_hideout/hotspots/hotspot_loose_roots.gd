@tool
extends PopochiuHotspot
## Loose Roots hotspot - Roots hanging from the ditch wall

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Tree roots poking out of the dirt.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to use that with the roots.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Tree roots hang down from the wall!")
	await C.player.say("They look strong enough to climb on!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab the roots and pull myself up!")
	await C.player.say("They hold my weight! These could help me escape!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello roots! Will you help me climb out?")
	await C.player.say("They seem sturdy and reliable!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I tug on the roots.")
	await C.player.say("They're attached pretty firmly to the tree!")


#endregion
