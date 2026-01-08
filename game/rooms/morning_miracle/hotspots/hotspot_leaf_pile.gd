@tool
extends PopochiuHotspot
## Hotspot: Leaf Pile (THE VOID WHERE MY LEG WAS / Leaf Pile with leg)
## The key hotspot for the Vision Tutorial - labels are DRAMATICALLY different

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	if room.state.leg_revealed:
		await C.Tank.say("Just a pile of leaves now. My leg is fine!")
		return

	# Start the leg reveal dialog
	D.LegReveal.start()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["leaf_pile"])
	await C.Tank.say(text)

	# Different reactions based on vision mode - THIS IS THE TUTORIAL
	if TankVision.is_reality_mode:
		if not room.state.leg_revealed:
			await E.queue([
				"*You notice something leg-shaped under the leaves*",
				"*Maybe you should examine more closely?*",
			])
	else:
		if not room.state.leg_revealed:
			await C.Tank.say("The emptiness... it consumes me...")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"Rock":
			await E.queue([
				"Tank: I'll mark this spot with a memorial stone!",
				"Tank: 'HERE LIES TANK'S LEG'",
			])
		_:
			await C.Tank.say("I can't use that on my tragedy!")
