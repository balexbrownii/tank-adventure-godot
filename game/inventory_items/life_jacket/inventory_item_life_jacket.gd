@tool
extends PopochiuInventoryItem
## Life Jacket - Keeps Mr. Snuggles afloat during the sea crossing.
## Crafted from driftwood, cloth, and vine rope.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Mr. Snuggles' life jacket!")
	await C.player.say("Crafted with LOVE!")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("FLOATY ARMOR FOR OUR DEER FRIEND!")
		await C.player.say("He shall not sink!")
	else:
		await C.player.say("A functional life jacket for Mr. Snuggles.")
		await C.player.say("Made from driftwood floats, tarp, and vine straps.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The life jacket is already complete!")


#endregion
