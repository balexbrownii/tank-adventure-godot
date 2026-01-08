@tool
extends PopochiuInventoryItem
## Space Soot - Collected during space drift. Comedy item but might be useful later.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Space soot. I'm covered in it!")
	await C.player.say("Smells like burning donut... and regret.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("STARDUST! From my epic space adventure!")
	else:
		await C.player.say("Carbonized debris from re-entry. Basically fancy ash.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to mix anything with space soot.")


#endregion
