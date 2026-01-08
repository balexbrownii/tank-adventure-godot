@tool
extends PopochiuHotspot
## Hotspot: Moonlight Gap
## The opening above showing the night sky

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	await E.queue([
		"Tank: *reaches toward the moonlight*",
		"Tank: I can't quite reach the sky...",
		"Tank: Someday I'll punch the MOON!",
	])


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["moonlight_gap"])
	await C.Tank.say(text)

	# Atmospheric moment
	await E.queue([
		"*The moon hangs silently above*",
		"*Somewhere, a wolf howls*",
	])


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"Rock":
			await E.queue([
				"Tank: *throws rock at moon*",
				"*The rock disappears into the darkness*",
				"Tank: ...I'll get you someday, moon.",
			])
		_:
			await C.Tank.say("I can't reach that high.")
