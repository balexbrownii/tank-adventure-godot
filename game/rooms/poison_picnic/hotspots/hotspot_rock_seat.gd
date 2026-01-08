@tool
extends PopochiuHotspot
## Hotspot: Rock Seat (PICNIC THRONE / Large Flat Rock)
## A comfortable spot for breakfast - the starting position

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	await E.queue([
		"Tank: *settles onto the rock*",
		"Tank: A warrior's throne for a warrior's breakfast!",
	])


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["rock_seat"])
	await C.Tank.say(text)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"RockChalk":
			await E.queue([
				"Tank: *draws on rock*",
				"Tank: 'TANK'S BREAKFAST SPOT - DO NOT DISTURB'",
			])
		_:
			await C.Tank.say("I should just sit and eat, not play with things.")


#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await _on_look()


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await _on_interact()


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello rock! You're a good sitting rock!")
	await C.player.say("Very... rocky of you.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("This rock is huge! I can't pick it up.")
	await C.player.say("Well, maybe I COULD but it's such a good seat...")


#endregion
