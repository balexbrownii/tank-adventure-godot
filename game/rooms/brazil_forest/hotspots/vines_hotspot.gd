extends "res://game/components/hotspot.gd"
## Vines Hotspot - Thick vines blocking the path (can be cut with machete)

const ROOM_ID := "brazil_forest"


func _ready() -> void:
	super._ready()
	display_name = "Thick Vines"
	look_text = "Thick vines block the path. They look tough to cut through."
	default_text = "The vines are too thick to move by hand."

	# Hide if already cut
	if GameManager.get_room_state(ROOM_ID, "vines_cut", false):
		visible = false


func _on_use() -> void:
	GameManager.show_message("You can't cut through these vines with your bare hands.")


func _on_use_item(item: String) -> void:
	if item == "machete":
		GameManager.show_message("You hack through the thick vines with the machete!")
		GameManager.set_room_state(ROOM_ID, "vines_cut", true)
		visible = false
		# Update the path hotspot description
		var path_node := get_parent().get_node_or_null("PathToVillage")
		if path_node and "look_text" in path_node:
			path_node.look_text = "The path to the village is now clear."
	else:
		GameManager.show_message("That won't cut through these tough vines.")


func _on_push() -> void:
	GameManager.show_message("You push against the vines but they don't budge.")


func _on_pull() -> void:
	GameManager.show_message("You pull at the vines but they're too thick and tangled.")
