@tool
extends PopochiuHotspot
## Hotspot: Room Door - your assigned room

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["room_door"])
	await C.Tank.say(text)


func _on_interact() -> void:
	if not room.state.got_room:
		await C.Tank.say("I need to get a room first!")
		return

	await E.queue([
		"*Room 7 is small but clean*",
		"*There's a bed, a towel, and a window overlooking the dock*",
	])
