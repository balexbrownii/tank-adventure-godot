@tool
extends PopochiuInventoryItem
## Inventory Item: Leaf Wrap
## An upgraded blanket - leaves woven with root fibers

var vision_data: Dictionary = {
	"tank_label": "FOREST COCOON",
	"tank_description": "A masterwork of survival crafting! Pig would be impressed!",
	"reality_label": "Leaf Wrap",
	"reality_description": "Leaves woven with root fibers. Actually pretty cozy."
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
	await C.Tank.say("My crafted %s! I made this myself!" % label)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("The leaf wrap is already perfect!")
