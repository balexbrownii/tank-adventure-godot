@tool
extends PopochiuHotspot
## Hotspot: Rock Seat (PICNIC THRONE / Large Flat Rock)
## A comfortable spot for breakfast - the starting position

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	await E.queue([
		"Tank: *settles onto the rock*",
		"Tank: A warrior's throne for a warrior's breakfast!",
	])


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["rock_seat"])
	await C.Tank.say(text)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"RockChalk":
			await E.queue([
				"Tank: *draws on rock*",
				"Tank: 'TANK'S BREAKFAST SPOT - DO NOT DISTURB'",
			])
		_:
			await C.Tank.say("I should just sit and eat, not play with things.")
