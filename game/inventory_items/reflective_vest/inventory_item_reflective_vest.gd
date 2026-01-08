@tool
extends PopochiuInventoryItem
## Inventory Item: Reflective Vest
## Classic disguise. Workers everywhere wear these.


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("My OFFICIAL UNIFORM!")


func _on_item_looked_at() -> void:
	if TankVision.is_reality_mode:
		await E.queue([
			"*A standard reflective safety vest.*",
			"*Workers wearing these blend right in.*",
		])
	else:
		await E.queue([
			"Tank: SHINY ARMOR OF INVISIBILITY!",
			"Tank: When I wear this, I become INVISIBLE to enemies!",
		])


func _on_item_used_on_prop(prop: PopochiuProp) -> void:
	await C.Tank.say("I show them my official vest!")


func _on_item_used_on_inventory_item(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("The vest doesn't combine with that!")
