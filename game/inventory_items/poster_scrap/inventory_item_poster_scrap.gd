@tool
extends PopochiuInventoryItem
## Poster Scrap - A piece of Tank's wanted poster.
## Optional collectible item.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("A piece of my wanted poster!")
	await C.player.say("I look so good in this picture.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("MY FAN ART!")
		await C.player.say("Someone drew me! I'm famous!")
	else:
		await C.player.say("A torn piece of the wanted poster.")
		await C.player.say("The reward amount is concerning.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("This is a keepsake. I shouldn't mess with it.")


#endregion
