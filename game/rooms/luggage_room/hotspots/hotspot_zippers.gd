@tool
extends PopochiuHotspot
## Zippers hotspot - Suitcase zippers for hiding

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Zippers on various suitcases.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't zip that up.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Zippers! The key to getting in and out!")
	await C.player.say("Pig says to leave them slightly open so we can breathe.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("ZZZZIP! I test the zipper.")
	await C.player.say("Works smoothly! Good zipper!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello zipper! Please don't get stuck!")
	await C.player.say("The zipper slides smoothly. Cooperative!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't take just the zipper.")
	await C.player.say("It's attached to the suitcase!")


#endregion
