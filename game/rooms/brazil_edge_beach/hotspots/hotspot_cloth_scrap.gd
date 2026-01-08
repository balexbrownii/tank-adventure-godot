@tool
extends PopochiuHotspot
## Hotspot: Cloth Scrap (VICTORY BANNER MATERIAL / Trailer Tarp torn)
## Water-resistant material for life jacket body

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	if room.state.jacket_crafted:
		await C.Tank.say("We used most of that for Mr. Snuggles' jacket.")
		return

	await E.queue([
		"Tank: *examines cloth*",
		"Tank: This would make a GREAT flag!",
		"Pig: Or... a life jacket body.",
		"Tank: OR A FLAG ON A LIFE JACKET!",
		"Pig: Sure. That too.",
	])


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["cloth_scrap"])
	await C.Tank.say(text)

	if TankVision.is_reality_mode:
		await E.queue([
			"*The tarp material is water-resistant*",
			"*Good for keeping water out of the life jacket*",
		])


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"Thorn":
			await E.queue([
				"Tank: *pokes hole in cloth with thorn*",
				"Pig: Why would you do that?!",
				"Tank: ...oops?",
			])
		_:
			await C.Tank.say("The cloth doesn't need that.")
