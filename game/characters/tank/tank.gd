extends CharacterBody2D
## Tank - Player character with click-to-move navigation
##
## Features:
## - Click anywhere on walkable area to move
## - Simple pathfinding via NavigationAgent2D
## - Sprite flipping based on direction

signal arrived_at_destination
signal started_moving

@export var walk_speed := 150.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var is_moving := false
var target_position: Vector2


func _ready() -> void:
	# Configure navigation agent
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 8.0
	nav_agent.navigation_finished.connect(_on_navigation_finished)
	print("[Tank] Character ready at position: %s" % global_position)


func _physics_process(_delta: float) -> void:
	if not is_moving:
		return

	if nav_agent.is_navigation_finished():
		_stop_moving()
		return

	var next_path_position := nav_agent.get_next_path_position()
	var direction := global_position.direction_to(next_path_position)

	# Flip sprite based on direction
	if direction.x != 0:
		sprite.flip_h = direction.x < 0

	velocity = direction * walk_speed
	move_and_slide()


func move_to(destination: Vector2) -> void:
	target_position = destination
	nav_agent.target_position = destination

	# Only start moving if we're not already at the destination
	if global_position.distance_to(destination) > nav_agent.target_desired_distance:
		is_moving = true
		started_moving.emit()
		print("[Tank] Moving to: %s" % destination)


func _stop_moving() -> void:
	is_moving = false
	velocity = Vector2.ZERO
	arrived_at_destination.emit()
	print("[Tank] Arrived at destination")


func _on_navigation_finished() -> void:
	_stop_moving()


# Called when clicking on walkable area
func _on_walkable_area_clicked(click_position: Vector2) -> void:
	move_to(click_position)


# Face a specific position (for talking to NPCs etc)
func face_position(pos: Vector2) -> void:
	sprite.flip_h = pos.x < global_position.x


# Stop any current movement (for interactions)
func stop() -> void:
	is_moving = false
	velocity = Vector2.ZERO
	nav_agent.target_position = global_position
