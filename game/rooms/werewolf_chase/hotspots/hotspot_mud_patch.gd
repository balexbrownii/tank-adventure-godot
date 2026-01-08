@tool
extends PopochiuHotspot
## Mud patch hotspot - Slippery hazard / sticky mud source

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WerewolfChase
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("CHOCOLATE PUDDLE!")
		await C.player.say("Ooh, forest chocolate!")
		await E.queue([
			"Tank considers tasting the mud",
			"Tank: Hmm, smells earthy...",
			"Tank: Must be EXTRA chocolatey!"
		])
	else:
		await C.player.say("Thick, slippery mud.")
		await C.player.say("Better watch my step here.")

	# Can collect sticky mud if didn't faceplant
	if not room.state.sticky_mud_taken and not room.state.mud_faceplant:
		await E.queue([
			"Tank scoops up some particularly sticky mud",
			"Tank: This stuff is really clingy!"
		])
		I.StickyMud.add_to_inventory()
		room.state.sticky_mud_taken = true


func _on_right_click() -> void:
	var room = R.WerewolfChase
	var inspect = TankVision.get_inspect_text(room.vision_data["mud_patch"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to drop anything in the mud!")


#endregion
