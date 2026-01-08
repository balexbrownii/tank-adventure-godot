@tool
extends PopochiuHotspot
## Hotspot: Motel Front Desk - where to get a room

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["motel_desk"])
	await C.Tank.say(text)


func _on_interact() -> void:
	if room.state.got_room:
		await E.queue([
			"Clerk: You already have a room. 7.",
			"Tank: RIGHT! I forgot!",
		])
		return

	room.trigger_room_puzzle()
