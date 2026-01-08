@tool
extends PopochiuInventoryItem
## Debris Trinket - Optional shiny space junk collected from debris field.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("My space treasure!")
	await C.player.say("I think it's part of a satellite. Or maybe a doorknob.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("SPACE TREASURE! The shiniest treasure from the void!")
		await C.player.say("It probably has magical space powers!")
	else:
		await C.player.say("A piece of metal debris. Could be useful as a tool or weight.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("My space treasure isn't compatible with that.")


#endregion
