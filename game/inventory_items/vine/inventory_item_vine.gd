@tool
extends PopochiuInventoryItem
## Vine - Sturdy vine for climbing or tying.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("A sturdy vine!")
	await C.player.say("Good for climbing or tying things.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("NATURE ROPE!")
		await C.player.say("The forest gave me a gift!")
	else:
		await C.player.say("A coil of sturdy vine.")
		await C.player.say("Could be useful for various things.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I should save the vine for something important.")


#endregion
