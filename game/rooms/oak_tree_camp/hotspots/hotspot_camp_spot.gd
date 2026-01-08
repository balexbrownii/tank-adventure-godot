@tool
extends PopochiuHotspot
## Camp Spot hotspot - Where the team rests

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Our campsite for the night.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to add that to the camp.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Our camp under the oak tree!")
	await C.player.say("Pig set up everything. So organized!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I arrange the camp supplies.")
	await C.player.say("Nice and tidy! Pig would be proud!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello camp! You're very cozy!")
	await C.player.say("The camp seems inviting and safe.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up the whole campsite.")
	await C.player.say("We just set it up!")


#endregion
