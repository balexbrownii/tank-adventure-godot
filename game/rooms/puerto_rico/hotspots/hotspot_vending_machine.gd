@tool
extends PopochiuHotspot
## Hotspot: Vending Machine - snacks!

@onready var room: Node = get_parent().get_parent()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["vending_machine"])
	await C.Tank.say(text)


func _on_interact() -> void:
	room.check_vending_machine()
