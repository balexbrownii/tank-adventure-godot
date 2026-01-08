@tool
extends PopochiuHotspot
## Leaf Pile hotspot - Where Tank wakes up

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A pile of dead leaves. Surprisingly comfortable.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to hide that in the leaves.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The leaf pile I slept in last night!")
	await C.player.say("It was surprisingly cozy. Nature's bed!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I shuffle through the leaves.")
	await C.player.say("Crunch crunch crunch! Fun!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Thank you for keeping me warm, leaves!")
	await C.player.say("The leaves rustle appreciatively. Maybe.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab a handful of leaves!")
	await C.player.say("What would I even do with these?")


#endregion
