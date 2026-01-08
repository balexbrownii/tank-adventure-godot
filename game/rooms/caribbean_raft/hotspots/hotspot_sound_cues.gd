@tool
extends PopochiuHotspot
## Sound Cues hotspot - Mysterious sounds in the fog

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Strange sounds from somewhere in the fog.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't use that on a sound.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I hear something out there in the fog!")
	await C.player.say("Splashing? Or maybe whale songs?")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I cup my hand to my ear.")
	await C.player.say("Definitely something alive out there!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("HELLO? IS SOMEONE THERE?")
	await C.player.say("Only echoes and waves answer back.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up sounds.")
	await C.player.say("Though I wish I could bottle that whale song!")


#endregion
