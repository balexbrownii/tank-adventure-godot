@tool
extends PopochiuHotspot
## Hotspot: Car + Trailer (LAND VESSEL BROKEN / Abandoned Car + Trailer)
## The motorcycle-towed trailer that brought them here

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	await E.queue([
		"Tank: *pats trailer*",
		"Tank: You served us well, noble land-ship!",
		"Pig: It's a trailer. We towed it.",
		"Tank: AND IT WAS GLORIOUS!",
	])


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["car_trailer"])
	await C.Tank.say(text)

	# Check for useful items
	if not room.state.jacket_crafted:
		await E.queue([
			"*There's a torn tarp on the trailer*",
			"*Could be useful for crafting*",
		])


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"MotorcycleKey":
			await E.queue([
				"Tank: Should I try to start it?",
				"Pig: Tank, we're goin' by SEA now.",
				"Tank: RIGHT! SEA!",
			])
		_:
			await C.Tank.say("The trailer doesn't need that anymore.")
