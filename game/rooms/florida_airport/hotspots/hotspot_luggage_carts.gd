@tool
extends PopochiuHotspot
## Hotspot: Luggage Carts - where the vest/clipboard are

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["luggage_carts"])
	await C.Tank.say(text)

	# Hint about disguise in Reality mode
	room.check_vest_location()


func _on_interact() -> void:
	if room.state.entered_airport:
		await C.Tank.say("We don't need the cart anymore!")
		return

	await E.queue([
		"*You examine the luggage cart*",
		"*A reflective vest and clipboard sit on top*",
		"Tank: DISGUISE MATERIALS!",
	])
