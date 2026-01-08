@tool
extends PopochiuHotspot
## Hotspot: Case File - Pig's navigation notes

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["case_file"])
	await C.Tank.say(text)


func _on_interact() -> void:
	room.check_case_file()
