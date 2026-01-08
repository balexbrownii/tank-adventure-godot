@tool
extends PopochiuHotspot

## Destination Tags hotspot - MYSTERIOUS LABELS / Destination Tags
## This is the key hotspot for the Device 6 style tag text puzzle

@onready var room: Node = get_parent().get_parent()


func _on_click() -> void:
	await C.Tank.walk_to_clicked()
	await C.Tank.face_clicked()

	if not room.state.found_texas_suitcase:
		# Start the suitcase choice dialog
		await D.SuitcaseChoice.start()
	else:
		await C.Tank.say("Already solved the tag puzzle!")


func _on_right_click() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["destination_tags"])
	await C.Tank.say(inspect_text)


func _on_look() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["destination_tags"])
	await C.Tank.say(inspect_text)

	if not room.state.found_texas_suitcase:
		await E.queue([
			"The tags have scrambled text.",
			"Maybe rotating or folding them would help...",
		])


func _on_interact() -> void:
	await _on_click()


func get_description() -> String:
	return TankVision.get_hover_text(room.vision_data["destination_tags"])
