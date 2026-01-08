@tool
extends PopochiuHotspot
## Hotspot: Birds Overhead (SKY COMPANIONS / Circling Birds)
## Ominous vultures circling - Tank thinks they're friends

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	await E.queue([
		"Tank: *waves at birds*",
		"Tank: Hello, sky friends!",
		"Tank: Are you cheering me on?!",
	])

	# Optional chalk item
	if not room.state.took_chalk:
		await E.queue([
			"*A bird drops something*",
			"Tank: A gift from above!",
		])
		room.take_rock_chalk()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["birds_overhead"])
	await C.Tank.say(text)

	# Reality mode shows the truth
	if TankVision.is_reality_mode:
		await E.queue([
			"*Those are definitely vultures*",
			"*They seem to be waiting for something...*",
		])


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"PoisonMushrooms":
			await E.queue([
				"Tank: Want some food, sky friends?",
				"*The birds circle lower, interested...*",
				"Tank: More for me then!",
			])
		_:
			await C.Tank.say("The sky friends don't want that.")
