@tool
extends PopochiuHotspot

## Deer Latch hotspot - DEER HOUSE DOOR / Suitcase Latch

@onready var room: Node = get_parent().get_parent()


func _on_click() -> void:
	await C.Tank.walk_to_clicked()
	await C.Tank.face_clicked()

	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["deer_latch"])
	await C.Tank.say(inspect_text)


func _on_right_click() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["deer_latch"])
	await C.Tank.say(inspect_text)


func _on_look() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["deer_latch"])
	await C.Tank.say(inspect_text)

	await E.queue([
		"*tap tap tap* from inside",
		"Mr. Snuggles is in there.",
	])


func _on_interact() -> void:
	await C.Tank.walk_to_clicked()

	if not room.state.crash_prepped:
		await E.queue([
			"*Tank touches the suitcase latch*",
			"*tap tap tap*",
		])
		await C.Tank.say("Don't worry, Mr. Snuggles! We'll protect you!")

		if GameState.has_party_member("Pig"):
			await C.player.say("We need to secure that suitcase before impact!")
	else:
		await E.queue([
			"*tap tap tap*",
		])
		await C.Tank.say("Stay safe in there, buddy.")


func get_description() -> String:
	return TankVision.get_hover_text(room.vision_data["deer_latch"])
