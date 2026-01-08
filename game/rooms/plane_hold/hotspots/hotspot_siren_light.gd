@tool
extends PopochiuHotspot

## Siren Light hotspot - BLINKY DISCO BALL / Emergency Siren

@onready var room: Node = get_parent().get_parent()


func _on_click() -> void:
	await C.Tank.face_clicked()
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["siren_light"])
	await C.Tank.say(inspect_text)


func _on_right_click() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["siren_light"])
	await C.Tank.say(inspect_text)


func _on_look() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["siren_light"])
	await C.Tank.say(inspect_text)

	await E.queue([
		"*BWEEE BWEEE BWEEE*",
		"The light flashes urgently.",
	])


func _on_interact() -> void:
	await E.queue([
		"*Tank reaches for the light*",
	])

	if TankVision.is_tank_vision:
		await C.Tank.say("I want to touch the disco ball!")
		await E.queue([
			"*The light is too high to reach*",
			"*Probably for the best*",
		])
	else:
		await C.Tank.say("This is the emergency warning. We need to prepare!")


func get_description() -> String:
	return TankVision.get_hover_text(room.vision_data["siren_light"])
