@tool
extends PopochiuInventoryItem
## Inventory Item: Charcoal Chunk
## Optional item - can be used for writing or stealth face paint

var vision_data: Dictionary = {
	"tank_label": "WAR PAINT",
	"tank_description": "For marking my face before BATTLE! Or writing heroic messages!",
	"reality_label": "Charcoal Chunk",
	"reality_description": "A piece of charcoal. Could write with it or use as camouflage."
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
	await C.Tank.say("My %s! Black as the night!" % label)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("I should use the charcoal on something, not combine it.")
