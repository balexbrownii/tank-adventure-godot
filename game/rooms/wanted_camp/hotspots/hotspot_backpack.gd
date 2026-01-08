@tool
extends PopochiuHotspot
## Backpack hotspot - Tank's supplies

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WantedCamp
	if room.state.backpack_taken:
		await C.player.say("I already took my backpack.")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("TREASURE SACK! Full of mysteries!")
		await C.player.say("And probably food!")
	else:
		await C.player.say("My backpack. Should probably take it.")

	# Start the take backpack dialog
	await D.TakeBackpack.start()


func _on_right_click() -> void:
	var room = R.WantedCamp
	var inspect = TankVision.get_inspect_text(room.vision_data["backpack"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I should just take the backpack.")


#endregion
