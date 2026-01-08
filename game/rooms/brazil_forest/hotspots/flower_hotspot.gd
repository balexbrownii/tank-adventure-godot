extends "res://game/components/hotspot.gd"
## Flower Hotspot - Exotic flower that can be picked

const ROOM_ID := "brazil_forest"


func _ready() -> void:
	super._ready()
	display_name = "Exotic Flower"
	look_text = "A beautiful exotic flower with vibrant purple petals. It looks valuable."
	default_text = "Be gentle with the flower."

	# Hide if already taken
	if GameManager.get_room_state(ROOM_ID, "flower_taken", false):
		visible = false


func _on_take() -> void:
	if not GameManager.get_room_state(ROOM_ID, "flower_taken", false):
		GameManager.add_item("flower")
		GameManager.set_room_state(ROOM_ID, "flower_taken", true)
		GameManager.show_message("You carefully pick the exotic flower.")
		visible = false
	else:
		GameManager.show_message("You already took the flower.")
