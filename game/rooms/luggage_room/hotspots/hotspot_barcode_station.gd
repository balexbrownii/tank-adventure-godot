@tool
extends PopochiuHotspot

## Barcode Scanner Station hotspot - BEEP MACHINE / Barcode Scanner

@onready var room: Node = get_parent().get_parent()


func _on_click() -> void:
	await C.Tank.walk_to_clicked()
	await C.Tank.face_clicked()

	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["barcode_station"])
	await C.Tank.say(inspect_text)

	await E.queue([
		"*BEEP*",
	])


func _on_right_click() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["barcode_station"])
	await C.Tank.say(inspect_text)


func _on_look() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["barcode_station"])
	await C.Tank.say(inspect_text)

	await E.queue([
		"The red light blinks rhythmically.",
		"Each suitcase that passes gets scanned.",
	])


func _on_interact() -> void:
	await C.Tank.walk_to_clicked()

	await E.queue([
		"*BEEP*",
	])

	if TankVision.is_tank_vision:
		await C.Tank.say("Hello beep machine! Are you trying to say something?")
		await E.queue([
			"*BEEP*",
			"Tank: I'll take that as a yes!",
		])
	else:
		await C.Tank.say("It reads tags and routes suitcases.")
		if GameState.has_party_member("Pig"):
			await C.player.say("Standard airport tech. Don't touch it.")


func get_description() -> String:
	return TankVision.get_hover_text(room.vision_data["barcode_station"])
