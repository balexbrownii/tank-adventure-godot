@tool
extends PopochiuHotspot
## Hotspot: Fog Wall - The impenetrable mist

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["fog_wall"])
	await C.Tank.say(text)


func _on_interact() -> void:
	await E.queue([
		"*You reach into the fog*",
		"*Your hand disappears immediately*",
		"Tank: It's like the world just... stops.",
		"Pig: It's fog, Tank. It ain't magic.",
		"Tank: FOG MAGIC!",
	])
