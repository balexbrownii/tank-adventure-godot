@tool
extends PopochiuHotspot
## Rock pile hotspot - Fist-sized rocks for throwing or hiding behind

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WantedCamp
	if room.state.rock_taken:
		await C.player.say("I already grabbed a good rock.")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("PET ROCKS!")
		await C.player.say("So many rocks! I should collect them all!")
		await E.queue([
			"Tank examines each rock carefully",
			"Tank: This one looks lonely...",
			"Tank: I'll take you with me, little friend!"
		])
	else:
		await C.player.say("A pile of fist-sized rocks.")
		await C.player.say("Good for throwing... or hiding behind.")

	await E.queue([
		"Tank picks up a particularly good rock",
		"Tank: A fine rock! Smooth and throwable!"
	])

	I.Rock.add_to_inventory()
	room.state.rock_taken = true


func _on_right_click() -> void:
	var room = R.WantedCamp
	var inspect = TankVision.get_inspect_text(room.vision_data["rock_pile"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The rocks are fine on their own.")


#endregion
