@tool
extends PopochiuInventoryItem
## Inventory Item: Boat Token
## Silly "permission slip" for borrowing a boat.


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("Official boat permission! LEGITIMATE!")


func _on_item_looked_at() -> void:
	if TankVision.is_reality_mode:
		await E.queue([
			"*A stamped 'Boat Borrow Form'*",
			"*'Permission granted for one (1) boat.'*",
			"*Surprisingly official-looking.*",
		])
	else:
		await E.queue([
			"Tank: PROOF that we're allowed to SEA CAR!",
			"Tank: The ink stamp makes it OFFICIAL!",
		])


func _on_item_used_on_prop(prop: PopochiuProp) -> void:
	await C.Tank.say("I show them my official permission!")


func _on_item_used_on_inventory_item(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("The paper doesn't work with that!")
