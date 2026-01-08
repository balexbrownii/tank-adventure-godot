@tool
extends PopochiuHotspot
## Oak Tree hotspot - The big oak tree at camp

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A majestic oak tree.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("The tree doesn't need that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("What a beautiful oak tree!")
	await C.player.say("Pig says it's the perfect landmark for our camp!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I hug the tree!")
	await C.player.say("Strong and steady! Good tree!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello mighty oak! Watch over our camp!")
	await C.player.say("The leaves rustle reassuringly.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I could probably uproot this tree...")
	await C.player.say("But that would be mean to the tree!")


#endregion
