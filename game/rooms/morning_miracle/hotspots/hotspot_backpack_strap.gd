@tool
extends PopochiuHotspot
## Hotspot: Backpack Strap (SURVIVAL LIFELINE / Twisted strap)
## Tank's backpack - a connection to her "former" life

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	await E.queue([
		"Tank: *adjusts backpack*",
		"Tank: At least I still have my supplies...",
	])

	if I.Backpack.is_in_inventory():
		await C.Tank.say("The pack is secure.")
	else:
		await C.Tank.say("I should probably grab my pack before moving on.")


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["backpack_strap"])
	await C.Tank.say(text)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Tank.say("I should keep my items accessible, not stuff them in the pack.")
