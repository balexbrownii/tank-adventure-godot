@tool
extends PopochiuHotspot
## Hollow log hotspot - Can crawl through for escape

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WerewolfChase
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("A NATURE TUNNEL!")
		await C.player.say("Secret passages are the BEST!")
	else:
		await C.player.say("A hollow log.")
		await C.player.say("I could crawl through it to escape.")

	# Can take bark
	if not room.state.hollow_log_bark_taken:
		await E.queue([
			"Tank notices some loose bark on the log",
			"Tank: This bark looks useful!"
		])
		I.HollowLogBark.add_to_inventory()
		room.state.hollow_log_bark_taken = true


func _on_right_click() -> void:
	var room = R.WerewolfChase
	var inspect = TankVision.get_inspect_text(room.vision_data["hollow_log"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The log is fine as is!")


#endregion
