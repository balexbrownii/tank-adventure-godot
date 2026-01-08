@tool
extends PopochiuInventoryItem
## Life Jacket (Bulky) - Tank's overbuilt version with too much driftwood.
## Works but slows raft travel.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Mr. Snuggles' EXTRA SAFE life jacket!")
	await C.player.say("With MAXIMUM flotation!")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("THE ULTIMATE FLOATY ARMOR!")
		await C.player.say("So much wood! SO SAFE!")
	else:
		await C.player.say("An overbuilt life jacket with excessive driftwood.")
		await C.player.say("Works, but slows down raft travel.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("It's already as bulky as it needs to be!")


#endregion
