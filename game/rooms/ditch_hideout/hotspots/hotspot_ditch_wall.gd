@tool
extends PopochiuHotspot
## Hotspot: Ditch Wall
## The earthy walls of Tank's refuge

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	await E.queue([
		"Tank: *pats the dirt wall*",
		"Tank: Thank you, Earth, for this shelter!",
	])


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["ditch_wall"])
	await C.Tank.say(text)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"CharcoalChunk":
			await E.queue([
				"Tank: *draws on wall*",
				"Tank: 'TANK WAS HERE'!",
				"Tank: Future archaeologists will be AMAZED!",
			])
		_:
			await C.Tank.say("The wall doesn't need that.")
