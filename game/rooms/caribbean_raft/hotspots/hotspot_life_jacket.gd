@tool
extends PopochiuHotspot
## Hotspot: Life Jacket on Mr. Snuggles

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["life_jacket"])
	await C.Tank.say(text)

	await E.queue([
		"Mr. Snuggles: *floats contentedly*",
	])

	# Check which jacket type from Room 11
	if I.LifeJacketBulky.is_in_inventory():
		await E.queue([
			"*The oversized jacket makes him bob like a cork*",
			"*He doesn't seem to mind*",
		])


func _on_interact() -> void:
	await E.queue([
		"Tank: You okay, Mr. Snuggles?",
		"Mr. Snuggles: *calm blink*",
		"Tank: He's SO BRAVE!",
	])
