@tool
extends PopochiuInventoryItem
## Rope - Made from coastal vines. Useful for tying things.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Vine rope!")
	await C.player.say("Strong and natural!")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("NATURE'S BINDING!")
		await C.player.say("For tying up enemies... or friends... or things!")
	else:
		await C.player.say("Rope made from coastal vines.")
		await C.player.say("Sturdy. Good for securing things.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I'll save the rope for when I need to tie something!")


#endregion
