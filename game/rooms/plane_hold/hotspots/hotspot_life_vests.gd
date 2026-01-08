@tool
extends PopochiuHotspot

## Life Vests hotspot - FLOATY PILLOWS / Emergency Life Vests

@onready var room: Node = get_parent().get_parent()


func _on_click() -> void:
	await C.Tank.walk_to_clicked()
	await C.Tank.face_clicked()

	if not room.state.crash_prepped:
		await D.CrashPrep.start()
	else:
		await C.Tank.say("Already dealt with the floaty pillows!")


func _on_right_click() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["life_vests"])
	await C.Tank.say(inspect_text)


func _on_look() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["life_vests"])
	await C.Tank.say(inspect_text)


func _on_interact() -> void:
	await _on_click()


func get_description() -> String:
	return TankVision.get_hover_text(room.vision_data["life_vests"])
