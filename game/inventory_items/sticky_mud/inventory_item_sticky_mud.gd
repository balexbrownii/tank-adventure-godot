@tool
extends PopochiuInventoryItem
## Sticky Mud - Very adhesive mud from the forest floor.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Super sticky mud!")
	await C.player.say("It's really clingy.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("FOREST CHOCOLATE THAT STICKS!")
		await C.player.say("The stickiest chocolate!")
	else:
		await C.player.say("Extremely sticky mud.")
		await C.player.say("Could use it as an adhesive.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to waste the sticky mud.")


#endregion
