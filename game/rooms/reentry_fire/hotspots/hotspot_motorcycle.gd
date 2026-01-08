@tool
extends PopochiuHotspot
## Motorcycle hotspot - Main puzzle target. Tank needs to start this to escape.

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	if room.state.solution_used != "":
		await C.player.say("Already got this metal horse running!")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await _tank_vision_interaction()
	else:
		await _reality_vision_interaction()


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["motorcycle"])
	await C.player.say(inspect)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if item.script_name == "MotorcycleKey":
		await C.player.say("A key! For the metal horse!")
		await room.execute_brains_solution()
	elif item.script_name == "RoadSignArrow":
		await C.player.say("Maybe I can use this as a lever...")
		await room.execute_bizarre_solution()
	else:
		await C.player.say("I don't think that will help start this thing.")


#endregion

#region Private ####################################################################################
func _tank_vision_interaction() -> void:
	await C.player.say("A METAL HORSE! I must tame it!")
	await C.player.say("But how do you make a metal horse go?")

	# Show approach options
	await D.MotorcycleApproach.start()


func _reality_vision_interaction() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	room.state.motorcycle_examined_reality = true

	await C.player.say("A motorcycle. I need to start it and get out of here.")
	await C.player.say("Let's see... there's a button, a grip, and a kick lever.")

	GameState.modify_ignorance(2)

	# Show approach options
	await D.MotorcycleApproach.start()


#endregion
