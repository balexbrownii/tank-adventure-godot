@tool
extends PopochiuHotspot
## Hotspot: Boat - your ride to Florida

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["boat"])
	await C.Tank.say(text)

	if TankVision.is_reality_mode:
		await E.queue([
			"*A 'Boat Borrow Form' is posted nearby*",
			"*There's a stamp at the front desk*",
		])


func _on_interact() -> void:
	if room.state.got_boat:
		await C.Tank.say("We already have this boat!")
		return

	if not room.state.got_room and not room.state.slept_outside:
		await E.queue([
			"Pig: Let's rest first, then we can figure out the boat.",
		])
		return

	room.trigger_boat_puzzle()
