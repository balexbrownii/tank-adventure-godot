@tool
extends PopochiuHotspot
## Oak Tree hotspot - Distant tree that will be the camp in next room.

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("A BIG TREE FRIEND in the distance!")
		await C.player.say("It's waving at me! Hello, tree!")
	else:
		await C.player.say("A large oak tree. Could make a good camp spot.")
		await C.player.say("Looks peaceful.")

	if not room.state.pig_joined:
		await C.player.say("Maybe we could head there after I sort things out here.")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["oak_tree"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The tree is too far away to use that on.")


#endregion
