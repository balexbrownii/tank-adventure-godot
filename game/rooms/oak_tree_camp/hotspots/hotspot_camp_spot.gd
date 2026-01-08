@tool
extends PopochiuHotspot
## Camp spot hotspot - Main puzzle trigger for camp security

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.camp_secured:
		await C.player.say("The camp is all set up and secure!")
		return

	if room.state.breakfast_done:
		await C.player.say("We already had breakfast. Time to move on!")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("OUR FORTRESS! We must defend it!")
	else:
		await C.player.say("A good spot to make camp.")
		await C.player.say("We should secure it for the night.")

	# Show camp security options
	await D.CampSafety.start()


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["camp_spot"])
	await C.player.say(inspect)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.camp_secured:
		await C.player.say("The camp's already set up.")
		return

	if item.script_name == "CraftKit":
		await C.player.say("Maybe I can use this to make a trap...")
		await room.execute_brains_solution()
	else:
		await C.player.say("I don't need that for the camp right now.")


#endregion
