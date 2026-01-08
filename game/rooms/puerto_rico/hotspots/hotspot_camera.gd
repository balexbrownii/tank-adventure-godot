@tool
extends PopochiuHotspot
## Hotspot: Fake Security Camera with googly eyes

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["camera"])
	await C.Tank.say(text)


func _on_interact() -> void:
	room.check_fake_camera()
