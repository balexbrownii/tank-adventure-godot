@tool
extends PopochiuInventoryItem
## Inventory Item: Root Fiber
## Strong fibrous roots for crafting

var vision_data: Dictionary = {
	"tank_label": "EARTH TENDONS",
	"tank_description": "Strong like me! The earth shares its strength!",
	"reality_label": "Root Fiber",
	"reality_description": "Flexible root fibers. Good for tying or weaving things together."
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
	await C.Tank.say("Some %s. Very fibrous!" % label)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"LeafBlanket":
			# Crafting combination!
			await E.queue([
				"Tank: If I weave the roots through the leaves...",
				"Tank: *crafting sounds*",
				"Tank: A LEAF WRAP! Much better!",
			])
			I.LeafBlanket.remove()
			I.RootFiber.remove()
			I.LeafWrap.add()
		"Vine":
			await C.Tank.say("Both are good for tying things. I don't need to combine them.")
		_:
			await C.Tank.say("I can't weave roots into that.")
