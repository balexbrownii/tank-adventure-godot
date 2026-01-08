@tool
extends PopochiuHotspot
## Hotspot: Palm Trees - for sneaking

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["tree_line"])
	await C.Tank.say(text)


func _on_interact() -> void:
	await E.queue([
		"*Tank hides behind a palm tree*",
		"Tank: *whispers* No one can see me!",
		"Pig: Tank, you're twice the width of that tree.",
		"Tank: PERFECT CAMOUFLAGE!",
	])
