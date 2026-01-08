@tool
extends PopochiuHotspot

## Suitcase Pile hotspot - BOX MOUNTAIN / Suitcase Pile

@onready var room: Node = get_parent().get_parent()


func _on_click() -> void:
	await C.Tank.walk_to_clicked()
	await C.Tank.face_clicked()

	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["suitcase_pile"])
	await C.Tank.say(inspect_text)


func _on_right_click() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["suitcase_pile"])
	await C.Tank.say(inspect_text)


func _on_look() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["suitcase_pile"])
	await C.Tank.say(inspect_text)


func _on_interact() -> void:
	# Main interaction - look for specific suitcases
	await C.Tank.walk_to_clicked()

	if not room.state.found_texas_suitcase:
		await C.Tank.say("So many boxes... which one goes to Texas?")

		# Prompt to check tags
		await E.queue([
			"Tank should check the destination tags.",
		])
	else:
		await C.Tank.say("Already found our Texas box!")


func get_description() -> String:
	return TankVision.get_hover_text(room.vision_data["suitcase_pile"])
