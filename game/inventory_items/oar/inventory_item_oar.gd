@tool
extends PopochiuInventoryItem
## Oar - For paddling the raft. Essential for sea crossing.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("A sturdy oar!")
	await C.player.say("For paddling!")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("THE PROPULSION DEVICE!")
		await C.player.say("I shall row us to VICTORY!")
	else:
		await C.player.say("A wooden oar. Works for paddling.")
		await C.player.say("Could also work as a basic weapon if needed.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The oar is fine as it is!")


#endregion
