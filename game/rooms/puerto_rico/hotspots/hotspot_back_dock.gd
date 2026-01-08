@tool
extends PopochiuHotspot
## Back Dock hotspot - Where boats are kept

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A dock behind the motel.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to use that here.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The dock behind the motel!")
	await C.player.say("Several boats are tied up here...")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I check the dock for loose boards.")
	await C.player.say("Seems sturdy enough!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello dock! Any nice boats here?")
	await C.player.say("It creaks mysteriously.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a whole dock!")
	await C.player.say("It's attached to the shore!")


#endregion
