@tool
extends PopochiuHotspot
## Hotspot: Oar - For rowing when direction is known

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["oar"])
	await C.Tank.say(text)


func _on_interact() -> void:
	if room.state.navigation_solved:
		await C.Tank.say("We're already heading the right way!")
		return

	await E.queue([
		"Tank: *grabs oar eagerly*",
		"Tank: Which way do I paddle?!",
		"Pig: That's the problem - we don't know yet.",
		"Tank: I COULD JUST PADDLE RANDOMLY!",
		"Pig: No. Absolutely not.",
	])
