extends CanvasLayer
class_name DialogSystem
## DialogSystem - Branching dialog for adventure game
##
## Shows dialog text with optional choices.
## Data-driven: define dialogs as dictionaries.

signal dialog_started
signal dialog_ended
signal choice_selected(choice_id: String)

@onready var panel: PanelContainer = $DialogPanel
@onready var speaker_label: Label = $DialogPanel/VBox/SpeakerLabel
@onready var text_label: Label = $DialogPanel/VBox/TextLabel
@onready var choices_container: VBoxContainer = $DialogPanel/VBox/ChoicesContainer
@onready var continue_label: Label = $DialogPanel/VBox/ContinueLabel

var current_dialog: Array = []  # Array of dialog nodes
var current_node_index := 0
var is_active := false
var is_waiting_for_choice := false


func _ready() -> void:
	panel.visible = false
	continue_label.visible = false
	print("[DialogSystem] Dialog system ready")


func _input(event: InputEvent) -> void:
	if not is_active:
		return

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not is_waiting_for_choice:
			_advance_dialog()


# Start a dialog sequence
# dialog_data is an array of nodes:
# [
#   {"speaker": "Tank", "text": "Hello!"},
#   {"speaker": "Pig", "text": "Howdy!", "choices": [
#     {"id": "ask_village", "text": "Where's the village?"},
#     {"id": "ask_vines", "text": "How do I cut these vines?"},
#     {"id": "bye", "text": "Goodbye."}
#   ]},
#   {"speaker": "Tank", "text": "Thanks!", "condition": "ask_village"}
# ]
func start_dialog(dialog_data: Array) -> void:
	if dialog_data.is_empty():
		return

	current_dialog = dialog_data
	current_node_index = 0
	is_active = true
	panel.visible = true
	dialog_started.emit()

	_show_current_node()


func _show_current_node() -> void:
	if current_node_index >= current_dialog.size():
		end_dialog()
		return

	var node: Dictionary = current_dialog[current_node_index]

	# Check condition if present
	if node.has("condition"):
		var condition: String = node["condition"]
		if not GameManager.has_flag("dialog_" + condition):
			current_node_index += 1
			_show_current_node()
			return

	# Show speaker and text
	speaker_label.text = node.get("speaker", "")
	text_label.text = node.get("text", "")

	# Clear previous choices
	for child in choices_container.get_children():
		child.queue_free()

	# Check for choices
	if node.has("choices"):
		is_waiting_for_choice = true
		continue_label.visible = false
		_show_choices(node["choices"])
	else:
		is_waiting_for_choice = false
		continue_label.visible = true


func _show_choices(choices: Array) -> void:
	for choice in choices:
		var btn := Button.new()
		btn.text = choice.get("text", "...")
		btn.pressed.connect(_on_choice_pressed.bind(choice.get("id", "")))
		choices_container.add_child(btn)


func _on_choice_pressed(choice_id: String) -> void:
	# Set flag for this choice
	GameManager.set_flag("dialog_" + choice_id, true)
	choice_selected.emit(choice_id)

	is_waiting_for_choice = false
	_advance_dialog()


func _advance_dialog() -> void:
	current_node_index += 1
	_show_current_node()


func end_dialog() -> void:
	is_active = false
	panel.visible = false
	current_dialog = []
	current_node_index = 0
	dialog_ended.emit()
	print("[DialogSystem] Dialog ended")


# Quick helper to show a single line of dialog
func say(speaker: String, text: String) -> void:
	start_dialog([{"speaker": speaker, "text": text}])


# Check if dialog is currently active
func is_dialog_active() -> bool:
	return is_active
