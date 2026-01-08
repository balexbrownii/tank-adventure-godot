@tool
extends PopochiuInventoryItem
## Spinach Leaves - Food item from Pig's supplies.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Spinach leaves. Pig says they're healthy.")
	await C.player.say("I prefer donuts, but I'll take what I can get.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("GREEN POWER LEAVES!")
		await C.player.say("Pig says they make you strong! Like me!")
	else:
		await C.player.say("Fresh spinach leaves. Surprisingly well-preserved.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I could eat these, but I'll save them for later.")


#endregion
