@tool
extends PopochiuInventoryItem
## Inventory Item: Drift Bottle Note
## A message in a bottle found at sea. Contains hints.
## Bonus item for smart navigation solution.


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("A message from the SEA PEOPLE!")


func _on_item_looked_at() -> void:
	if TankVision.is_reality_mode:
		await E.queue([
			"*A faded note found floating in a bottle.*",
			"*It reads: 'If lost at sea, follow the gulls.'*",
			"*Sound advice from a previous sailor.*",
		])
		# Award hint token for finding this
		GameState.award_hint_tokens(1)
		await E.queue([
			"*+1 Hint Token*",
		])
	else:
		await E.queue([
			"Tank: *squints at note*",
			"Tank: 'If lost at see, follow the guls.'",
			"Tank: What's a GUL?! Is it dangerous?!",
			"Pig: *sighs*",
		])


func _on_item_used_on_prop(prop: PopochiuProp) -> void:
	await C.Tank.say("The note doesn't help with that!")


func _on_item_used_on_inventory_item(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("Paper doesn't combine well with things!")
