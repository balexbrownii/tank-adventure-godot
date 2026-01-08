@tool
extends PopochiuInventoryItem
## Bacon Crumbs - Remnants of the commander's sandwich.
## Can be used to lure soldiers or as a bizarre tribute.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Bacon crumbs!")
	await C.player.say("They smell SO good.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("DELICIOUS MEMORIES!")
		await C.player.say("The sacred remains of the BEST sandwich ever!")
	else:
		await C.player.say("Crumbs from the commander's sandwich.")
		await C.player.say("Still aromatic. Could be useful as a lure.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to contaminate these precious crumbs.")


#endregion
