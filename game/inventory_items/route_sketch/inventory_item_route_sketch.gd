@tool
extends PopochiuInventoryItem
## Route Sketch - Pig's hand-drawn map showing the journey to Canada.
## Quest log item that tracks the current objective.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Pig's route sketch!")
	await C.player.say("Brazil coast... Caribbean Sea... Puerto Rico... Florida... CANADA!")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("THE TREASURE MAP!")
		await C.player.say("X marks... somewhere! In CANADA!")
	else:
		await C.player.say("A rough sketch of our route to Canada.")
		await C.player.say("Pig's handwriting is surprisingly neat.")
		await C.player.say("Current objective: Reach the Brazil coastline.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I should keep the map safe, not combine it with things.")


#endregion
