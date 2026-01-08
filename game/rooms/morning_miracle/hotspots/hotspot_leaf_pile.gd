@tool
extends PopochiuHotspot
## Leaf Pile hotspot - Tank's morning bed

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Leaves. Lots of autumn leaves.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to hide that in the leaves.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The leaf pile where I woke up!")
	await C.player.say("Wait... something's under there...")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I brush away the leaves.")
	await C.player.say("There's something underneath!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Good morning, leaves!")
	await C.player.say("Thanks for keeping me warm!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I scoop up some leaves.")
	await C.player.say("Crinkly!")


#endregion
