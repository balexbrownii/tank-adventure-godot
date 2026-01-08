@tool
extends PopochiuHotspot
## Oar hotspot - For paddling the raft

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Our oar. For steering and paddling.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to combine that with the oar.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A sturdy oar I made from driftwood!")
	await C.player.say("Perfect for rowing to Puerto Rico!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I paddle vigorously!")
	await C.player.say("WHOOSH! SPLASH! We're making progress!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Good oar! You're doing great work!")
	await C.player.say("The oar appreciates my encouragement. Probably.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab the oar firmly!")
	await C.player.say("Ready for rowing duty!")


#endregion
