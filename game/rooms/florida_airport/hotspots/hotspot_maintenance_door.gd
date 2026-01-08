@tool
extends PopochiuHotspot
## Hotspot: Staff/Maintenance Door

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["maintenance_door"])
	await C.Tank.say(text)


func _on_interact() -> void:
	if room.state.entered_airport:
		await C.Tank.say("We already found a way in!")
		return

	await E.queue([
		"*The door is locked*",
		"*'STAFF ONLY' sign is very clear*",
		"Tank: A CHALLENGE!",
		"Pig: Let's try the front entrance instead.",
	])
