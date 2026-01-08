@tool
extends PopochiuHotspot
## Vine coil hotspot - Sturdy vines that can be taken

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WantedCamp
	if room.state.vine_taken:
		await C.player.say("I already took some vine.")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("NATURE ROPE!")
		await C.player.say("Nature is so thoughtful!")
	else:
		await C.player.say("Sturdy vines. Could be useful.")

	# Start the take vine dialog
	await D.TakeVine.start()


func _on_right_click() -> void:
	var room = R.WantedCamp
	var inspect = TankVision.get_inspect_text(room.vision_data["vine_coil"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I should just take the vine.")


#endregion
