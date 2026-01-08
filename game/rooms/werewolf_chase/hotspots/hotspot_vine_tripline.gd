@tool
extends PopochiuHotspot
## Vine tripline hotspot - Hidden tripline hazard

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WerewolfChase
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("DECORATIVE STRING!")
		await C.player.say("Nature is so artistic!")
		if not room.state.triggered_tripline:
			room.state.triggered_tripline = true
			await E.queue([
				"Tank walks right into the vine",
				"TRIP!",
				"Tank: WHOA!"
			])
	else:
		await C.player.say("A vine stretched across the path.")
		await C.player.say("I should be careful not to trip on that.")


func _on_right_click() -> void:
	var room = R.WerewolfChase
	var inspect = TankVision.get_inspect_text(room.vision_data["vine_tripline"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("Can't mess with vines while running!")


#endregion
