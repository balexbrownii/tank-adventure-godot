@tool
extends PopochiuHotspot
## Hotspot: Stars - Key to Reality Vision navigation

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["stars"])
	await C.Tank.say(text)


func _on_interact() -> void:
	if room.state.navigation_solved:
		await C.Tank.say("We already found the way!")
		return

	if TankVision.is_reality_mode:
		await E.queue([
			"*You study the star pattern carefully*",
			"*A bright cluster forms a line pointing southeast*",
			"Pig: If we had the route sketch, we could confirm...",
		])
	else:
		await E.queue([
			"Tank: *squints at stars*",
			"Tank: I see... A BEAR! No wait, a WARRIOR!",
			"Tank: It's POINTING at something!",
			"Pig: ...that's actually not wrong.",
		])
