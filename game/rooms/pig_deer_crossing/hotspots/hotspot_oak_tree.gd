@tool
extends PopochiuHotspot
## Oak Tree hotspot - A tree at the crossing

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A shady oak tree by the road.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The tree doesn't need that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A nice oak tree providing shade!")
	await C.player.say("Pig says we could camp here!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I lean against the tree.")
	await C.player.say("Ahh, nice and shady!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello tree! Will you shelter us tonight?")
	await C.player.say("The branches sway welcomingly.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I could uproot this tree...")
	await C.player.say("But it provides such nice shade!")


#endregion
