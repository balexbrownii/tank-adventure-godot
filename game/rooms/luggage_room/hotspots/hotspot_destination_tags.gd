@tool
extends PopochiuHotspot
## Destination Tags hotspot - Airport routing tags

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Tags showing where bags are going.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to tag that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Destination tags! Each shows where a bag is going!")
	await C.player.say("I need to find one that says Texas!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I read the tags carefully.")
	await C.player.say("DFW... that's Dallas! Texas!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello tags! Which way to Texas?")
	await C.player.say("A tag flutters in the AC breeze. Is that a sign?")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab a DFW tag!")
	await C.player.say("This will get us to Texas!")


#endregion
