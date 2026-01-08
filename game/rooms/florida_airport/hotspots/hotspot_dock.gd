@tool
extends PopochiuHotspot
## Hotspot: Florida Dock - arrival point

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["dock"])
	await C.Tank.say(text)


func _on_interact() -> void:
	await E.queue([
		"*The boat rocks gently against the dock*",
		"Tank: Goodbye, SEA CAR! You served us well!",
	])
