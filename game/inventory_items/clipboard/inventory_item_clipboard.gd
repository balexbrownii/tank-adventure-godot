@tool
extends PopochiuInventoryItem
## Inventory Item: Clipboard
## Pairs with vest for the ultimate "I belong here" disguise.


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("I write IMPORTANT THINGS on this!")


func _on_item_looked_at() -> void:
	if TankVision.is_reality_mode:
		await E.queue([
			"*A standard clipboard with some forms.*",
			"*Holding one makes you look official.*",
		])
	else:
		await E.queue([
			"Tank: The WRITING SHIELD of AUTHORITY!",
			"Tank: People see this and think 'IMPORTANT PERSON'!",
		])


func _on_item_used_on_prop(prop: PopochiuProp) -> void:
	await C.Tank.say("I pretend to write something about it!")


func _on_item_used_on_inventory_item(item: PopochiuInventoryItem) -> void:
	# Vest + Clipboard combo
	if item.script_name == "ReflectiveVest":
		await E.queue([
			"Tank: THE ULTIMATE DISGUISE COMBO!",
			"*Vest + Clipboard = Official Worker*",
		])
	else:
		await C.Tank.say("I can't combine those!")
