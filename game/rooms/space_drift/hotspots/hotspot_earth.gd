@tool
extends PopochiuHotspot
## Earth hotspot - Tank's destination. Click to start approach selection.

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	if room.state.solution_used != "":
		await C.player.say("I'm already heading back!")
		return

	# Different interaction based on vision mode
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await _tank_vision_interaction()
	else:
		await _reality_vision_interaction()


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["earth"])
	await C.player.say(inspect)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == "DonutBox":
		await C.player.say("The donuts are pointing toward Earth! They want to go home too!")
	elif item.script_name == "Helmet":
		await C.player.say("Putting my helmet toward Earth won't help... I think.")
	else:
		await C.player.say("I don't think throwing that at Earth will work.")


#endregion

#region Private ####################################################################################
func _tank_vision_interaction() -> void:
	await C.player.say("THE BLUE MARBLE! My home!")
	await C.player.say("I can smell the donuts calling me back!")

	# Show approach options
	await D.SpaceDriftApproach.start()


func _reality_vision_interaction() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	room.state.earth_examined_reality = true

	await C.player.say("Earth. I need to get back there.")
	await C.player.say("But how do you 'swim' in space?")
	await C.player.say("Maybe that science thingy can help...")

	# Increase ignorance since Tank is thinking logically
	GameState.modify_ignorance(3)

	# Still show approach options
	await D.SpaceDriftApproach.start()


#endregion
