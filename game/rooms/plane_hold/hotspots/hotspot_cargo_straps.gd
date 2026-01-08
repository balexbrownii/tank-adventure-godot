@tool
extends PopochiuHotspot

## Cargo Straps hotspot - SEATBELT FRIENDS / Cargo Securing Straps

@onready var room: Node = get_parent().get_parent()


func _on_click() -> void:
	await C.Tank.walk_to_clicked()
	await C.Tank.face_clicked()

	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["cargo_straps"])
	await C.Tank.say(inspect_text)


func _on_right_click() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["cargo_straps"])
	await C.Tank.say(inspect_text)


func _on_look() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["cargo_straps"])
	await C.Tank.say(inspect_text)


func _on_interact() -> void:
	await C.Tank.walk_to_clicked()

	if not room.state.crash_prepped:
		await C.Tank.say("These could secure the deer suitcase!")
		if GameState.has_party_member("Pig"):
			await C.player.say("Good thinking! Use them in the crash prep!")
	else:
		await C.Tank.say("Already used the hugging straps!")


func get_description() -> String:
	return TankVision.get_hover_text(room.vision_data["cargo_straps"])
