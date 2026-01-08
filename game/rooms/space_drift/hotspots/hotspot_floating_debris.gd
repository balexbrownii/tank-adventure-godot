@tool
extends PopochiuHotspot
## Floating Debris hotspot - Space junk around Tank

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Chunks of stuff floating around me.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to add to the space junk!")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Floating debris from the explosion!")
	await C.player.say("Part of a gas pump... some asphalt...")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I push off the debris!")
	await C.player.say("WHOOSH! Now I'm spinning the other way!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello space junk! How'd you get up here?")
	await C.player.say("Oh right... same way I did.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab a chunk of debris!")
	await C.player.say("Could be useful for steering!")


#endregion
