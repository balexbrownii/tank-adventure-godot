@tool
extends PopochiuHotspot
## Hotspot: Moon - Obscured by fog

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["moon"])
	await C.Tank.say(text)

	if TankVision.is_reality_mode:
		await E.queue([
			"*The fog obscures most of the moon's light*",
			"*Not useful for navigation tonight*",
		])
