@tool
extends PopochiuHotspot
## Life Vests hotspot - Emergency flotation devices

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Emergency life vests.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("The life vests don't need that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Life vests! For water landings!")
	await C.player.say("Hopefully we won't need these!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I put on a life vest.")
	await C.player.say("Safety first! Pig would approve!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello life vests! Keep us safe!")
	await C.player.say("They inflate with optimism.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab some life vests!")
	await C.player.say("One for me, one for Pig, one for Mr. Snuggles!")


#endregion
