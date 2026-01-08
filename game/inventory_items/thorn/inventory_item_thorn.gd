@tool
extends PopochiuInventoryItem
## Thorn - A sharp thorn from the thorn bush.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("A nice sharp thorn!")
	await C.player.say("Good for poking things.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("NATURE'S TINY SWORD!")
		await C.player.say("For tiny battles!")
	else:
		await C.player.say("A large, sharp thorn.")
		await C.player.say("Could use it as a makeshift needle or weapon.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I should save the thorn for something important.")


#endregion
