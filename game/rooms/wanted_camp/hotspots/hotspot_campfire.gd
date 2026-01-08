@tool
extends PopochiuHotspot
## Campfire hotspot - Tank's small campfire

#region Virtual ####################################################################################
func _on_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("WARM FRIEND! The fire keeps the monsters away!")
		await C.player.say("I should tell it a story!")
		await E.queue([
			"Tank: Once upon a time, there was a sandwich...",
			"Tank: THE END! It was delicious!",
			"The fire crackles approvingly"
		])
	else:
		await C.player.say("A small campfire. Probably visible from far away...")
		await C.player.say("Not the stealthiest choice.")


func _on_right_click() -> void:
	var room = R.WantedCamp
	var inspect = TankVision.get_inspect_text(room.vision_data["campfire"])
	await C.player.say(inspect)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"BaconCrumbs":
			await E.queue([
				"Tank throws the bacon crumbs into the fire",
				"The fire flares with a bacon-scented whoosh",
				"Tank: A tribute to the Bacon Spirits!"
			])
		_:
			await C.player.say("I shouldn't burn that.")


#endregion
