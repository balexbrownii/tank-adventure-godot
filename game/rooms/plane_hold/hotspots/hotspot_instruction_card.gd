@tool
extends PopochiuHotspot

## Instruction Card hotspot - PICTURE BOOK / Emergency Instruction Card

@onready var room: Node = get_parent().get_parent()


func _on_click() -> void:
	await C.Tank.walk_to_clicked()
	await C.Tank.face_clicked()

	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["instruction_card"])
	await C.Tank.say(inspect_text)


func _on_right_click() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["instruction_card"])
	await C.Tank.say(inspect_text)


func _on_look() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["instruction_card"])
	await C.Tank.say(inspect_text)

	if TankVision.is_tank_vision:
		await E.queue([
			"The pictures show people doing funny poses.",
			"Are they yoga? A dance routine?",
		])
	else:
		await E.queue([
			"The card shows emergency procedures:",
			"1. Put on life vest",
			"2. Assume brace position",
			"3. Secure loose items",
		])


func _on_interact() -> void:
	await C.Tank.walk_to_clicked()

	await E.queue([
		"*Tank picks up the card and studies it*",
	])

	if TankVision.is_tank_vision:
		await C.Tank.say("Step 1: Wear the floaty pillow!")
		await C.Tank.say("Step 2: Do the bendy pose!")
		await C.Tank.say("Step 3: Hug your friends!")
	else:
		await C.Tank.say("Emergency landing procedures...")
		if GameState.has_party_member("Pig"):
			await C.player.say("We need to follow these. NOW!")


func get_description() -> String:
	return TankVision.get_hover_text(room.vision_data["instruction_card"])
