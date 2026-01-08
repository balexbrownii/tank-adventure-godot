@tool
extends PopochiuHotspot
## Hotspot: Airport Main Entrance - the puzzle trigger

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["airport_entrance"])
	await C.Tank.say(text)


func _on_interact() -> void:
	if room.state.entered_airport:
		await C.Tank.say("We already got in!")
		return

	room.trigger_entrance_puzzle()
