extends "res://game/components/hotspot.gd"
## Stump Hotspot - Tree stump with machete stuck in it

const ROOM_ID := "brazil_forest"


func _ready() -> void:
	super._ready()
	display_name = "Tree Stump"
	default_text = "It's just a stump."

	# Check if machete was already taken
	if GameManager.get_room_state(ROOM_ID, "machete_taken", false):
		look_text = "An old tree stump. There's a notch where the machete was."
	else:
		look_text = "An old tree stump with a machete stuck in it."


func _on_take() -> void:
	if not GameManager.get_room_state(ROOM_ID, "machete_taken", false):
		GameManager.add_item("machete")
		GameManager.set_room_state(ROOM_ID, "machete_taken", true)
		look_text = "An old tree stump. There's a notch where the machete was."
		GameManager.show_message("You pull the machete free from the stump.")
	else:
		GameManager.show_message("There's nothing else to take from the stump.")
