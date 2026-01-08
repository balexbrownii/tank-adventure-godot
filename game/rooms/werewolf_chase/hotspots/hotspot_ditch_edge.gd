@tool
extends PopochiuHotspot
## Ditch edge hotspot - Safety / escape destination

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WerewolfChase
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("A MYSTERIOUS HOLE!")
		await C.player.say("A portal to adventure!")
		await C.player.say("Or safety! Same thing!")
	else:
		await C.player.say("A deep ditch.")
		await C.player.say("If I jump in, the wolf might not be able to follow.")

	if room.state.chase_started and not room.state.escaped:
		await C.player.say("I need to get there! But the wolf is in the way!")


func _on_right_click() -> void:
	var room = R.WerewolfChase
	var inspect = TankVision.get_inspect_text(room.vision_data["ditch_edge"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I just need to get there!")


#endregion
