extends Area2D
class_name Hotspot
## Hotspot - Interactive area in adventure game rooms
##
## Extend this class and override _on_interact() to create
## specific hotspot behaviors.

signal clicked(hotspot: Hotspot)
signal hovered(hotspot: Hotspot)
signal unhovered(hotspot: Hotspot)

@export var display_name: String = "Something"
@export var look_text: String = "You see nothing special."
@export var default_text: String = "You can't do that."
@export var walk_to_position: Vector2 = Vector2.ZERO  # Where player walks to interact

var is_hovered := false


func _ready() -> void:
	# Connect mouse signals
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)

	# Set default collision
	if get_child_count() == 0:
		var collision := CollisionShape2D.new()
		var shape := RectangleShape2D.new()
		shape.size = Vector2(50, 50)
		collision.shape = shape
		add_child(collision)

	print("[Hotspot] %s ready" % display_name)


func _on_mouse_entered() -> void:
	is_hovered = true
	hovered.emit(self)
	# Update UI action text
	if is_instance_valid(get_tree().root.find_child("AdventureUI", true, false)):
		var ui = get_tree().root.find_child("AdventureUI", true, false)
		if ui.has_method("set_hover_target"):
			ui.set_hover_target(display_name)


func _on_mouse_exited() -> void:
	is_hovered = false
	unhovered.emit(self)
	# Clear UI action text
	if is_instance_valid(get_tree().root.find_child("AdventureUI", true, false)):
		var ui = get_tree().root.find_child("AdventureUI", true, false)
		if ui.has_method("clear_hover_target"):
			ui.clear_hover_target()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		clicked.emit(self)
		_handle_interaction()


func _handle_interaction() -> void:
	var verb := GameManager.current_verb
	var item := GameManager.selected_item

	print("[Hotspot] Interaction: %s on %s (item: %s)" % [GameManager.get_verb_text(), display_name, item])

	match verb:
		GameManager.Verb.LOOK:
			_on_look()
		GameManager.Verb.USE:
			if item:
				_on_use_item(item)
			else:
				_on_use()
		GameManager.Verb.TALK:
			_on_talk()
		GameManager.Verb.TAKE:
			_on_take()
		GameManager.Verb.PUSH:
			_on_push()
		GameManager.Verb.PULL:
			_on_pull()

	# Clear selected item after use attempt
	GameManager.clear_selected_item()
	# Reset to LOOK verb
	GameManager.set_verb(GameManager.Verb.LOOK)


# Override these in child classes for specific behavior
func _on_look() -> void:
	GameManager.show_message(look_text)


func _on_use() -> void:
	GameManager.show_message(default_text)


func _on_use_item(item: String) -> void:
	GameManager.show_message("You can't use the %s with that." % item)


func _on_talk() -> void:
	GameManager.show_message("It doesn't respond.")


func _on_take() -> void:
	GameManager.show_message(default_text)


func _on_push() -> void:
	GameManager.show_message(default_text)


func _on_pull() -> void:
	GameManager.show_message(default_text)
