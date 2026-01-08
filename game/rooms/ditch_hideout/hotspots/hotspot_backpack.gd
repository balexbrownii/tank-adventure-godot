@tool
extends PopochiuHotspot
## Hotspot: Backpack
## Tank's trusty supply pack

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	await E.queue([
		"Tank: Let me check my supplies...",
		"Tank: *rummages*",
	])

	# List what's in inventory
	if I.Backpack.is_in_inventory():
		await C.Tank.say("I've already got the backpack equipped.")
	else:
		await C.Tank.say("The pack is mostly empty now. Just some crumbs and lint.")


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["backpack"])
	await C.Tank.say(text)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("I should keep my items ready, not stuff them in the pack!")
