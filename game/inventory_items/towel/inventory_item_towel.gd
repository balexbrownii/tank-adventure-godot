@tool
extends PopochiuInventoryItem
## Inventory Item: Towel
## Optional item from motel. Can be used as bandage later.


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("A towel! Never leave home without one!")


func _on_item_looked_at() -> void:
	if TankVision.is_reality_mode:
		await E.queue([
			"*A clean motel towel.*",
			"*Could be useful as a bandage or padding.*",
		])
	else:
		await E.queue([
			"Tank: The ULTIMATE travel companion!",
			"Tank: Dry, wrap, wave, wear - VERSATILE!",
		])


func _on_item_used_on_prop(prop: PopochiuProp) -> void:
	await C.Tank.say("I towel it off!")


func _on_item_used_on_inventory_item(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("I wrap it in the towel!")
