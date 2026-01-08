@tool
extends PopochiuHotspot
## Pig hotspot - Main interaction target for recruitment puzzle.

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.pig_joined:
		await C.player.say("Pig is part of our team now!")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await _tank_vision_interaction()
	else:
		await _reality_vision_interaction()


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["pig"])
	await C.player.say(inspect)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if item.script_name == "DonutBox" or item.script_name == "MiniDonuts":
		if not room.state.pig_joined:
			await C.player.say("Maybe I can use these to make peace...")
			await room.execute_bizarre_solution()
		else:
			await C.player.say("Pig already joined us!")
	else:
		await C.player.say("I don't think giving that to the angry bacon will help.")


#endregion

#region Private ####################################################################################
func _tank_vision_interaction() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	await C.player.say("ANGRY BACON! It's yelling at me!")

	if room.state.pig_mood == "angry":
		await C.player.say("Why is the bacon so mad?!")

	# Show recruitment options
	await D.PigRecruitment.start()


func _reality_vision_interaction() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	room.state.pig_examined_reality = true

	await C.player.say("It's a pig in workout pants. Very angry.")
	await C.player.say("But also... kind of impressive? Those pants are TIGHT.")

	GameState.modify_ignorance(2)

	# Show recruitment options
	await D.PigRecruitment.start()


#endregion
