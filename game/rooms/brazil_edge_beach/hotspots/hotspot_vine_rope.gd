@tool
extends PopochiuHotspot
## Hotspot: Vine Rope (NATURE'S BINDINGS / Coastal Vines)
## Strapping material for life jacket crafting

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	if room.state.collected_rope:
		await C.Tank.say("I already grabbed some rope-vines!")
		return

	await E.queue([
		"Tank: *tugs on vines*",
		"Tank: Strong! Like me!",
		"Tank: *coils some up*",
	])

	if not room.state.jacket_crafted:
		await C.Tank.say("This will be useful for the life jacket!")


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["vine_rope"])
	await C.Tank.say(text)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"Thorn":
			await E.queue([
				"Tank: *uses thorn to cut vines*",
				"Tank: The thorn is USEFUL!",
			])
		_:
			await C.Tank.say("Vines don't need that.")
