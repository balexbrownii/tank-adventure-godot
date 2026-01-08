@tool
extends PopochiuHotspot
## Hotspot: Back Dock - where the boats are

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["back_dock"])
	await C.Tank.say(text)


func _on_interact() -> void:
	if room.state.got_boat:
		await C.Tank.say("We already have a boat!")
		return

	if not room.state.got_room and not room.state.slept_outside:
		await E.queue([
			"Pig: Let's get some rest first. Can't sail tired.",
		])
		return

	await E.queue([
		"*The dock is quiet in the pre-dawn darkness*",
		"*A few boats bob gently in the water*",
	])
