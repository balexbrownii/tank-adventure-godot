@tool
extends PopochiuHotspot
## Hotspot: Sound Cues - Listen for gulls

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["sound_cues"])
	await C.Tank.say(text)


func _on_interact() -> void:
	room.listen_for_sounds()
