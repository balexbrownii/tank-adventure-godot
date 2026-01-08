@tool
extends PopochiuInventoryItem
## Pig's Craft Kit - Unlocks the crafting system. Given by Pig when joining.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Pig's craft kit!")
	await C.player.say("It has tools for combining things together.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("THE MAGIC COMBINATION BOX!")
		await C.player.say("Pig said it makes new things from old things!")
	else:
		await C.player.say("A basic crafting kit. Thread, needle, small tools.")
		await C.player.say("Pig really knows how to prepare for travel.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	# The craft kit could be used to combine items in a full implementation
	await C.player.say("I could try to combine these...")
	await C.player.say("But I'm not sure what to make yet.")


#endregion
