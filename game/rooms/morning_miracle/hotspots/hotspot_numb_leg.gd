@tool
extends PopochiuHotspot
## Hotspot: Numb Leg (PHANTOM PAIN ZONE / Your asleep leg)
## The "phantom limb" that's actually just a numb leg

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	await room.check_numb_leg()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["numb_leg"])
	await C.Tank.say(text)

	# Vision toggle hint
	if not TankVision.is_reality_mode and not room.state.leg_revealed:
		await E.queue([
			"*The sensation is confusing...*",
			"*Try pressing TAB to see things differently*",
		])


func _on_item_used(item: PopochiuInventoryItem) -> void:
	if room.state.leg_revealed:
		await C.Tank.say("My leg is fine, I don't need to use anything on it.")
	else:
		await C.Tank.say("I can't use items on a phantom limb!")
