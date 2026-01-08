@tool
extends PopochiuHotspot
## Hotspot: Rock Marker (MEMORIAL STONE / Random Rock)
## A rock Tank might use as a memorial... or just trip over

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	if room.state.leg_revealed:
		await E.queue([
			"Tank: I should probably move this rock.",
			"Tank: Don't want to trip on it... again.",
		])
	else:
		if TankVision.is_reality_mode:
			await C.Tank.say("It's just a rock. You almost tripped on it last night.")
		else:
			await E.queue([
				"Tank: This stone shall serve as a MEMORIAL!",
				"Tank: Future travelers will know of my sacrifice!",
			])


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["rock_marker"])
	await C.Tank.say(text)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"CharcoalChunk":
			await E.queue([
				"Tank: *draws on rock*",
				"Tank: 'R.I.P. LEG'",
				"Tank: There. A proper memorial.",
			])
		_:
			await C.Tank.say("The rock doesn't need that.")
