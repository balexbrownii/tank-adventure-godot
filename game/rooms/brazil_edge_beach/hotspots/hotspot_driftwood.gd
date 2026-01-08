@tool
extends PopochiuHotspot
## Hotspot: Driftwood (FLOATY WOOD THINGS / Driftwood Pile)
## Flotation material for life jacket crafting

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	if room.state.jacket_crafted:
		await C.Tank.say("We already used the good pieces for the life jacket.")
		return

	await E.queue([
		"Tank: *picks up driftwood*",
		"Tank: These are VERY floaty!",
		"Pig: That's the idea. Driftwood floats.",
		"Tank: GENIUS!",
	])


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["driftwood"])
	await C.Tank.say(text)

	if TankVision.is_reality_mode:
		await E.queue([
			"*The driftwood looks weathered but solid*",
			"*Perfect for flotation*",
		])


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"Rope", "Vine":
			await C.Tank.say("I could tie these together... if I knew how to make a life jacket.")
		_:
			await C.Tank.say("Wood doesn't need that.")
