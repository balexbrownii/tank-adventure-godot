extends NavigationRegion2D
class_name WalkableArea
## WalkableArea - Defines where the player can walk
##
## Click within this area to move the player character.
## Uses NavigationRegion2D for pathfinding.

signal walk_requested(position: Vector2)

@export var player_path: NodePath


func _ready() -> void:
	# Enable navigation
	enabled = true
	print("[WalkableArea] Navigation region ready")


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos := get_global_mouse_position()

		# Check if click is within navigation polygon
		if _is_point_in_navigation(mouse_pos):
			# Only walk if no hotspot was clicked
			# Give hotspots a frame to process their click
			await get_tree().process_frame
			if not _was_hotspot_clicked():
				_move_player_to(mouse_pos)


func _is_point_in_navigation(point: Vector2) -> bool:
	if navigation_polygon == null:
		return false

	# Check if point is within any of the navigation polygon outlines
	for i in range(navigation_polygon.get_outline_count()):
		var outline := navigation_polygon.get_outline(i)
		if Geometry2D.is_point_in_polygon(to_local(point), outline):
			return true
	return false


func _was_hotspot_clicked() -> bool:
	# Check if mouse is over any Area2D (hotspot)
	var space_state := get_world_2d().direct_space_state
	var query := PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	var result := space_state.intersect_point(query)
	return not result.is_empty()


func _move_player_to(position: Vector2) -> void:
	walk_requested.emit(position)

	# If player_path is set, directly move the player
	if player_path:
		var player := get_node_or_null(player_path)
		if player and player.has_method("move_to"):
			player.move_to(position)
	else:
		# Try to find Tank in the scene
		var tank := get_tree().root.find_child("Tank", true, false)
		if tank and tank.has_method("move_to"):
			tank.move_to(position)


# Helper to create a simple rectangular walkable area
static func create_rect_polygon(rect: Rect2) -> NavigationPolygon:
	var polygon := NavigationPolygon.new()
	var outline := PackedVector2Array([
		rect.position,
		Vector2(rect.position.x + rect.size.x, rect.position.y),
		rect.position + rect.size,
		Vector2(rect.position.x, rect.position.y + rect.size.y)
	])
	polygon.add_outline(outline)
	polygon.make_polygons_from_outlines()
	return polygon
