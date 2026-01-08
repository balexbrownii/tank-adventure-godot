@tool
extends PopochiuHotspot
## Road hotspot - The road where they almost collided

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A country road. Dusty.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to put that on the road.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The road where I almost hit Pig and Mr. Snuggles!")
	await C.player.say("Good thing I stopped in time!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I check the road for traffic.")
	await C.player.say("All clear! Safe to cross!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello road! Where do you go?")
	await C.player.say("The road stretches on in both directions.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a road.")
	await C.player.say("It goes on forever!")


#endregion
