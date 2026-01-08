@tool
extends PopochiuHotspot
## Supplies Pouch hotspot - Pig's supply bag

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Pig's supplies pouch.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I shouldn't put things in Pig's bag without asking.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Pig's supply pouch!")
	await C.player.say("Full of maps, snacks, and emergency bacon.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I peek inside the pouch.")
	await C.player.say("Pig organizes everything so neatly!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello pouch! Keep Pig's stuff safe!")
	await C.player.say("It bulges with supplies.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I shouldn't take Pig's supplies.")
	await C.player.say("He'll need them for planning!")


#endregion
