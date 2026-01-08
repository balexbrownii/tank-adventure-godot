@tool
extends PopochiuHotspot
## Hotspot: Loose Roots
## Exposed roots from the ditch wall - can be harvested

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	if room.state.took_roots:
		await C.Tank.say("I already got the best roots from there.")
		return

	# Offer to take roots
	D.TakeRoots.start()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["loose_roots"])
	await C.Tank.say(text)

	if not room.state.took_roots:
		await C.Tank.say("I could pull some of these for crafting...")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"Vine":
			await C.Tank.say("I already have vine. These roots are similar but different!")
		_:
			await C.Tank.say("The roots don't need that.")
