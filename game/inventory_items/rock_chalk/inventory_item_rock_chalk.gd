@tool
extends PopochiuInventoryItem
## Rock Chalk - Chalky rock that can be used for writing messages.
## Optional collectible item for marking territory or writing signs.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Rock chalk!")
	await C.player.say("For writing important messages!")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("MY COMMUNICATION DEVICE!")
		await C.player.say("For marking territory and declaring victories!")
	else:
		await C.player.say("A piece of chalky rock.")
		await C.player.say("Good for writing on surfaces.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I need a surface to write on!")


#endregion
