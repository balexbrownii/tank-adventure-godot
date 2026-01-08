@tool
extends PopochiuHotspot
## Fog Wall hotspot - Mysterious fog on the sea

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Thick fog. Can't see anything through it.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't use that on fog.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The fog is so thick!")
	await C.player.say("It's like sailing through clouds!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to push the fog away.")
	await C.player.say("It just swirls around my hand.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello fog! Are you hiding ghosts?")
	await C.player.say("The fog doesn't answer. Suspicious.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab a handful of fog!")
	await C.player.say("...And it's gone. Sneaky fog.")


#endregion
