@tool
extends PopochiuHotspot
## Bush line hotspot - Dense bushes for hiding

#region Virtual ####################################################################################
func _on_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("FLUFFY HIDING PLACE!")
		await C.player.say("Perfect for hiding! Or napping!")
		await E.queue([
			"Tank considers crawling into the bushes",
			"Tank: So cozy looking...",
			"Tank: But I should probably stay by the fire."
		])
	else:
		await C.player.say("Thick bushes. Good cover for sneaking.")
		await C.player.say("Could hide in there if needed.")


func _on_right_click() -> void:
	var room = R.WantedCamp
	var inspect = TankVision.get_inspect_text(room.vision_data["bush_line"])
	await C.player.say(inspect)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"BaconCrumbs":
			await E.queue([
				"Tank sprinkles bacon crumbs near the bushes",
				"Tank: A trap for bacon lovers!",
				"Tank: Or a gift for the bush spirits!"
			])
		_:
			await C.player.say("The bushes don't need that.")


#endregion
