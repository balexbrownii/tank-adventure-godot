@tool
extends PopochiuInventoryItem
## Inventory Item: Motel Keycard
## Can be used as a "plastic shim" later.


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("The magic rectangle that opens doors!")


func _on_item_looked_at() -> void:
	if TankVision.is_reality_mode:
		await E.queue([
			"*A standard motel keycard for Room 7.*",
			"*Thin plastic. Could work as a shim.*",
		])
	else:
		await E.queue([
			"Tank: The SLEEP FORTRESS KEY!",
			"Tank: It has mysterious powers!",
		])


func _on_item_used_on_prop(prop: PopochiuProp) -> void:
	await C.Tank.say("I try to swipe the magic card!")


func _on_item_used_on_inventory_item(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("Cards don't combine with things!")
