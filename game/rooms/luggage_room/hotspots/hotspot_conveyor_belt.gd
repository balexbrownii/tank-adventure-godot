@tool
extends PopochiuHotspot

## Conveyor Belt hotspot - MOVING FLOOR / Conveyor Belt

@onready var room: Node = get_parent().get_parent()


func _on_click() -> void:
	await C.Tank.walk_to_clicked()
	await C.Tank.face_clicked()

	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["conveyor_belt"])
	await C.Tank.say(inspect_text)


func _on_right_click() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["conveyor_belt"])
	await C.Tank.say(inspect_text)


func _on_look() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["conveyor_belt"])
	await C.Tank.say(inspect_text)


func _on_interact() -> void:
	await C.Tank.walk_to_clicked()

	if room.state.found_texas_suitcase and not room.state.party_linked:
		# Party linking puzzle
		await C.Tank.say("The floor is taking our boxes different ways!")
		await D.KeepPartyTogether.start()
	elif not room.state.found_texas_suitcase:
		await C.Tank.say("Can't ride the floor until I know where to go!")
	else:
		await C.Tank.say("Already riding the moving floor!")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	# If player uses rope on conveyor
	if item.script_name == "Rope" or item.script_name == "MoistRope":
		if room.state.found_texas_suitcase and not room.state.party_linked:
			await room.execute_brains_rope_link()
		else:
			await C.Tank.say("No need for rope right now.")


func get_description() -> String:
	return TankVision.get_hover_text(room.vision_data["conveyor_belt"])
