@tool
extends PopochiuHotspot
## Hotspot: Beach (ADVENTURE SHORE / Sandy Beach)
## General beach atmosphere and setting

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	await E.queue([
		"Tank: *kicks sand*",
		"Tank: This is good sand! WARRIOR SAND!",
		"Pig: It's just... regular sand.",
	])


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["beach"])
	await C.Tank.say(text)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"Rock":
			await E.queue([
				"Tank: *throws rock into water*",
				"Tank: Skip! Skip! ...SINK.",
				"Tank: The ocean ate my rock!",
			])
		_:
			await C.Tank.say("The beach doesn't need that.")
