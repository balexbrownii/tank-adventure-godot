@tool
extends PopochiuHotspot
## Hotspot: Small Puddle
## Muddy water at the bottom of the ditch

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	await room.examine_puddle()

	# Optional: wash mud face if player has it from fail-forward
	if GameState.has_temporary_status("mud_face"):
		await E.queue([
			"Tank: *splashes water on face*",
			"Tank: There! Clean-ish!",
		])
		GameState.remove_temporary_status("mud_face")


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["small_puddle"])
	await C.Tank.say(text)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"CharcoalChunk":
			await E.queue([
				"Tank: *drops charcoal in puddle*",
				"Tank: ...Now it's charcoal water.",
				"Tank: I didn't think this through.",
			])
		_:
			await C.Tank.say("I don't want to get that wet.")
