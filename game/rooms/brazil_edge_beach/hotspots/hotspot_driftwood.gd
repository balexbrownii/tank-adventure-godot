@tool
extends PopochiuHotspot
## Driftwood hotspot - Useful for raft building

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Old wood that washed up on shore.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to combine that with the wood.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Driftwood! Perfect for building a raft!")
	await C.player.say("It looks sturdy enough to float.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I test the wood's strength by punching it.")
	await C.player.say("SOLID! This will make a great raft base!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("You will help us cross the sea, noble wood!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab the driftwood. It's heavy but manageable!")


#endregion
