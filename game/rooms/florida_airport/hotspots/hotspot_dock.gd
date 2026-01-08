@tool
extends PopochiuHotspot
## Dock hotspot - Where they arrived in Florida

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("The dock where we landed.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to use that here.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The dock where our boat landed!")
	await C.player.say("We made it to Florida! So close to Canada!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I tie the boat to the dock.")
	await C.player.say("Good knot! The boat won't float away!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Thanks dock! You welcomed us to Florida!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a dock.")
	await C.player.say("It's attached to the ground!")


#endregion
