@tool
extends PopochiuHotspot
## Oak tree hotspot - The camp's central landmark

#region Virtual ####################################################################################
func _on_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("THE WISE ELDER! So majestic!")
		await C.player.say("I shall ask it for guidance!")
		await E.queue([
			"Tank: TREE! Which way to Canada?!",
			"...",
			"Tank: It says... that way!",
			"Tank points in a random direction"
		])
	else:
		await C.player.say("A solid oak tree. Perfect for shelter.")
		await C.player.say("The branches provide good cover from rain.")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["oak_tree"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The tree doesn't need anything.")


#endregion
