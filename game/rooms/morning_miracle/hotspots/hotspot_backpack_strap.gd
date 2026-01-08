@tool
extends PopochiuHotspot
## Backpack Strap hotspot - Hanging from something

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A strap from my backpack is sticking out.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to attach that to the strap.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hey, that's my backpack strap!")
	await C.player.say("My backpack must be nearby!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I pull on the strap!")
	await C.player.say("My backpack emerges from the leaves!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hey strap! Where's my backpack?")
	await C.player.say("It seems to point under the leaves!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab the strap and pull!")
	await C.player.say("Found my backpack!")


#endregion
