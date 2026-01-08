@tool
extends PopochiuHotspot
## Hotspot: Leaf Pile
## The crucial pile that hides Tank's leg - sets up Room 4's "miracle"

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	# If camp already made, just describe
	if room.state.camp_made:
		await C.Tank.say("I should let it be until morning...")
		return

	# Offer to use as blanket
	await E.queue([
		"Tank: These leaves look comfortable enough...",
		"Tank: I could use them as a blanket!",
	])

	# If not already took leaves, offer to take
	if not room.state.took_leaves:
		D.TakeLeaves.start()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["leaf_pile"])
	await C.Tank.say(text)

	# Different reactions based on vision mode
	if not TankVision.is_reality_mode:
		await C.Tank.say("I dare not look upon it... the emptiness where my leg was...")
	else:
		await E.queue([
			"Tank: Wait... is something under there?",
			"Tank: Probably just a rock or something.",
		])


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"RootFiber":
			# Crafting hint
			await C.Tank.say("I could weave the roots through the leaves to make a better blanket!")
		_:
			await C.Tank.say("I don't think that goes there.")
