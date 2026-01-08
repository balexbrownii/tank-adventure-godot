extends CanvasLayer
## AdventureUI - Verb bar, inventory, and message display
##
## Classic LucasArts-style adventure game interface

@onready var verb_container: HBoxContainer = $VerbBar/VerbContainer
@onready var inventory_container: HBoxContainer = $InventoryPanel/InventoryContainer
@onready var action_label: Label = $ActionBar/ActionLabel
@onready var message_label: Label = $MessagePanel/MessageLabel
@onready var message_panel: PanelContainer = $MessagePanel

var verb_buttons := {}
var message_timer: Timer


func _ready() -> void:
	_create_verb_buttons()
	_setup_message_timer()

	# Connect to GameManager signals
	GameManager.inventory_changed.connect(_on_inventory_changed)
	GameManager.verb_changed.connect(_on_verb_changed)
	GameManager.message_displayed.connect(_on_message_displayed)

	# Initialize action text
	_update_action_label("")

	# Hide message panel initially
	message_panel.visible = false

	print("[AdventureUI] UI initialized")


func _create_verb_buttons() -> void:
	# Clear any existing buttons
	for child in verb_container.get_children():
		child.queue_free()

	# Create a button for each verb
	for verb in GameManager.Verb.values():
		var btn := Button.new()
		btn.text = GameManager.VERB_NAMES[verb]
		btn.custom_minimum_size = Vector2(80, 40)
		btn.pressed.connect(_on_verb_button_pressed.bind(verb))
		verb_container.add_child(btn)
		verb_buttons[verb] = btn

	# Highlight default verb (LOOK)
	_highlight_current_verb()


func _highlight_current_verb() -> void:
	for verb in verb_buttons:
		var btn: Button = verb_buttons[verb]
		if verb == GameManager.current_verb:
			btn.add_theme_color_override("font_color", Color.YELLOW)
		else:
			btn.remove_theme_color_override("font_color")


func _on_verb_button_pressed(verb: GameManager.Verb) -> void:
	GameManager.set_verb(verb)
	_highlight_current_verb()


func _on_verb_changed(verb_text: String) -> void:
	_highlight_current_verb()
	_update_action_label("")


func _update_action_label(target: String) -> void:
	action_label.text = GameManager.get_action_text(target)


func _on_inventory_changed() -> void:
	# Clear existing inventory buttons
	for child in inventory_container.get_children():
		child.queue_free()

	# Create button for each inventory item
	for item_id in GameManager.inventory:
		var btn := Button.new()
		btn.text = item_id.capitalize()
		btn.custom_minimum_size = Vector2(70, 50)
		btn.pressed.connect(_on_inventory_item_pressed.bind(item_id))
		inventory_container.add_child(btn)


func _on_inventory_item_pressed(item_id: String) -> void:
	if GameManager.current_verb == GameManager.Verb.USE:
		# Select item for "Use X with Y"
		GameManager.select_inventory_item(item_id)
		_update_action_label("")
	elif GameManager.current_verb == GameManager.Verb.LOOK:
		# Look at inventory item
		GameManager.show_message("It's your %s." % item_id)
	else:
		GameManager.show_message("You can't do that with the %s." % item_id)


func _setup_message_timer() -> void:
	message_timer = Timer.new()
	message_timer.one_shot = true
	message_timer.timeout.connect(_on_message_timer_timeout)
	add_child(message_timer)


func _on_message_displayed(text: String) -> void:
	message_label.text = text
	message_panel.visible = true
	message_timer.start(3.0)  # Show message for 3 seconds


func _on_message_timer_timeout() -> void:
	message_panel.visible = false


# Called when hovering over a hotspot
func set_hover_target(target_name: String) -> void:
	_update_action_label(target_name)


func clear_hover_target() -> void:
	_update_action_label("")
