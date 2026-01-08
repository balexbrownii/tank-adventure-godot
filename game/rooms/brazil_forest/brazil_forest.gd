extends Node2D
## Brazil Forest - Starting room for Tank's Great Adventure
##
## This is the first room where Tank and her companions arrive in the Brazilian
## rainforest. Interactive elements include: tree stump with machete, exotic flower,
## and vines blocking the path to the village.

const ROOM_ID := "brazil_forest"

@onready var stump_hotspot: Area2D = $Hotspots/Stump
@onready var flower_hotspot: Area2D = $Hotspots/Flower
@onready var vines_hotspot: Area2D = $Hotspots/Vines
@onready var path_hotspot: Area2D = $Hotspots/PathToVillage
@onready var tank: CharacterBody2D = $Characters/Tank


func _ready() -> void:
	print("[BrazilForest] Room loaded!")

	# Load saved room state
	_restore_state()

	# Connect hotspot interactions
	_setup_hotspots()

	# Show intro on first visit
	if not GameManager.has_flag("visited_brazil_forest"):
		GameManager.set_flag("visited_brazil_forest", true)
		await get_tree().create_timer(0.5).timeout
		_show_intro()


func _restore_state() -> void:
	# Check if machete was already taken
	if GameManager.get_room_state(ROOM_ID, "machete_taken", false):
		if stump_hotspot:
			stump_hotspot.look_text = "An old tree stump. There's a notch where something was stuck."

	# Check if flower was already taken
	if GameManager.get_room_state(ROOM_ID, "flower_taken", false):
		if flower_hotspot:
			flower_hotspot.visible = false

	# Check if vines were cut
	if GameManager.get_room_state(ROOM_ID, "vines_cut", false):
		if vines_hotspot:
			vines_hotspot.visible = false
		if path_hotspot:
			path_hotspot.look_text = "The path leads to a village."


func _setup_hotspots() -> void:
	# Stump hotspot
	if stump_hotspot:
		stump_hotspot.display_name = "Tree Stump"
		stump_hotspot.look_text = "An old tree stump with a machete stuck in it."
		stump_hotspot.default_text = "It's just a stump."

	# Flower hotspot
	if flower_hotspot:
		flower_hotspot.display_name = "Exotic Flower"
		flower_hotspot.look_text = "A beautiful exotic flower with vibrant purple petals."
		flower_hotspot.default_text = "Be gentle with it."

	# Vines hotspot
	if vines_hotspot:
		vines_hotspot.display_name = "Thick Vines"
		vines_hotspot.look_text = "Thick vines block the path. They look tough to cut."
		vines_hotspot.default_text = "The vines are too thick to move by hand."

	# Path to village
	if path_hotspot:
		path_hotspot.display_name = "Forest Path"
		path_hotspot.look_text = "A path leads deeper into the forest, but thick vines block the way."
		path_hotspot.default_text = "You can't get through the vines."


func _show_intro() -> void:
	GameManager.show_message("Tank finds herself in a lush Brazilian rainforest...")
	await get_tree().create_timer(2.0).timeout
	GameManager.show_message("Her companions Pig and Mr. Snuggles look around nervously.")


# Hotspot interaction handlers - connect these in _ready or via signals
func _on_stump_take() -> void:
	if not GameManager.get_room_state(ROOM_ID, "machete_taken", false):
		GameManager.add_item("machete")
		GameManager.set_room_state(ROOM_ID, "machete_taken", true)
		stump_hotspot.look_text = "An old tree stump. There's a notch where the machete was."
	else:
		GameManager.show_message("There's nothing else to take.")


func _on_flower_take() -> void:
	if not GameManager.get_room_state(ROOM_ID, "flower_taken", false):
		GameManager.add_item("flower")
		GameManager.set_room_state(ROOM_ID, "flower_taken", true)
		flower_hotspot.visible = false
	else:
		GameManager.show_message("You already took the flower.")


func _on_vines_use_item(item: String) -> void:
	if item == "machete":
		GameManager.show_message("You hack through the vines with the machete!")
		GameManager.set_room_state(ROOM_ID, "vines_cut", true)
		vines_hotspot.visible = false
		path_hotspot.look_text = "The path to the village is now clear."
	else:
		GameManager.show_message("That won't cut through these vines.")


func _on_path_use() -> void:
	if GameManager.get_room_state(ROOM_ID, "vines_cut", false):
		GameManager.show_message("You head down the path toward the village...")
		await get_tree().create_timer(1.0).timeout
		GameManager.go_to_room("res://game/rooms/brazil_village/brazil_village.tscn")
	else:
		GameManager.show_message("The vines are blocking the path!")


# Input handling for walkable area clicks
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Check if click is in walkable area and no hotspot was hit
		var click_pos := get_global_mouse_position()
		if _is_in_walkable_area(click_pos) and not _is_over_hotspot():
			if tank:
				tank.move_to(click_pos)


func _is_in_walkable_area(pos: Vector2) -> bool:
	var walkable := $WalkableAreas/WalkableArea as NavigationRegion2D
	if walkable and walkable.navigation_polygon:
		for i in range(walkable.navigation_polygon.get_outline_count()):
			var outline := walkable.navigation_polygon.get_outline(i)
			if Geometry2D.is_point_in_polygon(walkable.to_local(pos), outline):
				return true
	return false


func _is_over_hotspot() -> bool:
	var space_state := get_world_2d().direct_space_state
	var query := PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	var result := space_state.intersect_point(query)
	return not result.is_empty()
