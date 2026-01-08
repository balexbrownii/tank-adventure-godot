@tool
extends PopochiuHotspot
## Hotspot: Rental/Borrowed Car

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["car"])
	await C.Tank.say(text)


func _on_interact() -> void:
	await E.queue([
		"Pig: We should leave the car here.",
		"Pig: Don't want it tied to us when we fly out.",
		"Tank: STEALTH!",
	])
