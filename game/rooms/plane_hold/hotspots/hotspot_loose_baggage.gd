@tool
extends PopochiuHotspot

## Loose Baggage hotspot - SHIELD COLLECTION / Unsecured Cargo

@onready var room: Node = get_parent().get_parent()


func _on_click() -> void:
	await C.Tank.walk_to_clicked()
	await C.Tank.face_clicked()

	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["loose_baggage"])
	await C.Tank.say(inspect_text)


func _on_right_click() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["loose_baggage"])
	await C.Tank.say(inspect_text)


func _on_look() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["loose_baggage"])
	await C.Tank.say(inspect_text)

	await E.queue([
		"Suitcases, boxes, crates... all sliding around.",
		"They could become projectiles.",
	])


func _on_interact() -> void:
	await C.Tank.walk_to_clicked()

	if TankVision.is_tank_vision:
		await C.Tank.say("I'll use these as shields! Nothing can hurt me!")
		await E.queue([
			"*Tank grabs a suitcase*",
			"*It slides away as the plane shakes*",
		])
	else:
		await C.Tank.say("This cargo is dangerous. Flying debris in a crash...")
		if GameState.has_party_member("Pig"):
			await C.player.say("We could use them as padding, or lose everything!")


func get_description() -> String:
	return TankVision.get_hover_text(room.vision_data["loose_baggage"])
