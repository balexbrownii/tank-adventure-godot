@tool
extends PopochiuHotspot
## Ditch Wall hotspot - The earthen walls of the hiding spot

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("The wall of the ditch. Dirt and roots.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to use that on the wall.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The ditch walls are steep!")
	await C.player.say("Good for hiding from the WOLF!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to climb the wall.")
	await C.player.say("Dirt crumbles under my hands. Need another way out.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello dirt wall! You're doing great!")
	await C.player.say("The wall stands firm. Strong wall!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a wall.")
	await C.player.say("Even I know that!")


#endregion
