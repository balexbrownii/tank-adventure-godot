@tool
extends PopochiuInventoryItem
## Inventory Item: Leaf Blanket
## A makeshift blanket made of gathered leaves

var vision_data: Dictionary = {
	"tank_label": "NATURE ARMOR",
	"tank_description": "A protective covering made from the forest itself!",
	"reality_label": "Leaf Blanket",
	"reality_description": "A pile of leaves you can use as a blanket. Surprisingly warm."
}


func _on_interact() -> void:
	var desc: String = vision_data.reality_description
	if not TankVision.is_reality_mode:
		desc = vision_data.tank_description
	await C.Tank.say(desc)


func _on_look() -> void:
	var label: String = vision_data.reality_label
	if not TankVision.is_reality_mode:
		label = vision_data.tank_label
	await C.Tank.say("It's my %s!" % label)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"RootFiber":
			# Crafting combination!
			await E.queue([
				"Tank: If I weave the roots through the leaves...",
				"Tank: *crafting sounds*",
				"Tank: A LEAF WRAP! Much better!",
			])
			I.LeafBlanket.remove()
			I.RootFiber.remove()
			I.LeafWrap.add()
		_:
			await C.Tank.say("I can't combine those.")
