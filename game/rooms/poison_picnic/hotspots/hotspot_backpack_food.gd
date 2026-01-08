@tool
extends PopochiuHotspot
## Hotspot: Backpack Food (ADVENTURE SNACKS / Backpack Contents)
## The main puzzle - poisonous mushrooms and toxic sap bark
## THIS IS WHERE THE IGNORANCE MECHANIC IS TAUGHT!

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	if room.state.food_eaten:
		await C.Tank.say("Already had my warrior breakfast!")
		return

	# Start the food choice dialog - core puzzle
	room.trigger_food_choice()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["backpack_food"])
	await C.Tank.say(text)

	# CRITICAL: Reality mode reveals danger
	if TankVision.is_reality_mode:
		if not room.state.discovered_poison:
			await E.queue([
				"*Wait... those mushrooms have unusual markings*",
				"*They look like the poisonous ones from survival guides*",
			])
			# Examining triggers brains solution path
			room.execute_brains_solution()
	else:
		# Tank mode - blissfully unaware
		if not room.state.food_eaten:
			await C.Tank.say("I can't wait to eat these adventure snacks!")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"SapBark":
			await C.Tank.say("I already have some of that!")
		"PoisonMushrooms":
			await C.Tank.say("Mushrooms go IN my mouth, not ON more mushrooms.")
		_:
			await C.Tank.say("That won't make breakfast any better.")
