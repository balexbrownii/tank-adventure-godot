@tool
extends PopochiuInventoryItem
## Inventory Item: Moist Rope
## Soaked rope from the sea crossing. Still useful for tying things.


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("Soggy rope! It's like a wet noodle but STRONGER!")


func _on_item_looked_at() -> void:
	if TankVision.is_reality_mode:
		await E.queue([
			"*A length of rope, damp from the ocean spray.*",
			"*Still functional for tying or crafting.*",
		])
	else:
		await E.queue([
			"Tank: SEA SNAKE! No wait... it's just wet rope.",
			"Tank: DISAPPOINTING!",
		])


func _on_item_used_on_prop(prop: PopochiuProp) -> void:
	await C.Tank.say("Tie this? With wet rope? GENIUS!")


func _on_item_used_on_inventory_item(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("These should be BOUND together!")
