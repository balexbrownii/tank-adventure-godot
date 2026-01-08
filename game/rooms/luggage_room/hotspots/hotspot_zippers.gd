@tool
extends PopochiuHotspot

## Zippers hotspot - TEETH LINE / Zipper Mechanism

@onready var room: Node = get_parent().get_parent()


func _on_click() -> void:
	await C.Tank.walk_to_clicked()
	await C.Tank.face_clicked()

	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["zippers"])
	await C.Tank.say(inspect_text)


func _on_right_click() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["zippers"])
	await C.Tank.say(inspect_text)


func _on_look() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["zippers"])
	await C.Tank.say(inspect_text)


func _on_interact() -> void:
	await C.Tank.walk_to_clicked()

	if I.ZipperPull.is_in_inventory():
		await C.Tank.say("Already got a zipper pull!")
	else:
		await E.queue([
			"*Tank tugs on a zipper*",
			"*The zipper pull comes off in her hand*",
		])

		if TankVision.is_tank_vision:
			await C.Tank.say("I defeated the teeth! Victory!")
		else:
			await C.Tank.say("Oops. But this could be useful.")

		I.ZipperPull.add()
		await I.ZipperPull.add_popup()


func get_description() -> String:
	return TankVision.get_hover_text(room.vision_data["zippers"])
