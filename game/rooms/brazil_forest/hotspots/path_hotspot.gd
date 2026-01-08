extends "res://game/components/hotspot.gd"
## Path Hotspot - Path leading to the village (blocked by vines until cut)

const ROOM_ID := "brazil_forest"


func _ready() -> void:
	super._ready()
	display_name = "Forest Path"
	default_text = "The vines are blocking the path."

	# Check if vines have been cut
	if GameManager.get_room_state(ROOM_ID, "vines_cut", false):
		look_text = "The path to the village is now clear."
	else:
		look_text = "A path leads deeper into the forest, but thick vines block the way."


func _on_use() -> void:
	if GameManager.get_room_state(ROOM_ID, "vines_cut", false):
		GameManager.show_message("You head down the path toward the village...")
		# Transition to next scene
		await get_tree().create_timer(1.0).timeout
		GameManager.go_to_room("res://game/rooms/brazil_village/brazil_village.tscn")
	else:
		GameManager.show_message("Thick vines are blocking the path. You need to cut through them.")
