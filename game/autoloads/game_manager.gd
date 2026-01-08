extends Node
## GameManager - Core adventure game systems autoload
##
## Handles: game state, inventory, current verb, message display
## This replaces Popochiu's functionality with a simple CLI-compatible system.

signal inventory_changed
signal verb_changed(verb: String)
signal message_displayed(text: String)
signal interaction_triggered(target: String, verb: String, item: String)

# Available verbs (classic LucasArts style)
enum Verb { LOOK, USE, TALK, TAKE, PUSH, PULL }

const VERB_NAMES := {
	Verb.LOOK: "Look at",
	Verb.USE: "Use",
	Verb.TALK: "Talk to",
	Verb.TAKE: "Take",
	Verb.PUSH: "Push",
	Verb.PULL: "Pull"
}

# Current state
var current_verb: Verb = Verb.LOOK
var selected_item: String = ""  # For "Use X with Y" interactions
var inventory: Array[String] = []

# Game flags (persistent state across rooms)
var flags := {}

# Room state storage
var room_states := {}


func _ready() -> void:
	print("[GameManager] Adventure systems initialized")


# Verb management
func set_verb(verb: Verb) -> void:
	current_verb = verb
	selected_item = ""
	verb_changed.emit(get_verb_text())
	print("[GameManager] Verb set to: %s" % get_verb_text())


func get_verb_text() -> String:
	return VERB_NAMES.get(current_verb, "Look at")


func get_action_text(target_name: String = "") -> String:
	var text := get_verb_text()
	if selected_item:
		text += " " + selected_item + " with"
	if target_name:
		text += " " + target_name
	return text


# Inventory management
func add_item(item_id: String) -> void:
	if item_id not in inventory:
		inventory.append(item_id)
		inventory_changed.emit()
		show_message("Picked up: %s" % item_id)
		print("[GameManager] Added to inventory: %s" % item_id)


func remove_item(item_id: String) -> void:
	var idx := inventory.find(item_id)
	if idx >= 0:
		inventory.remove_at(idx)
		inventory_changed.emit()
		print("[GameManager] Removed from inventory: %s" % item_id)


func has_item(item_id: String) -> bool:
	return item_id in inventory


func select_inventory_item(item_id: String) -> void:
	if has_item(item_id):
		selected_item = item_id
		print("[GameManager] Selected item: %s" % item_id)


func clear_selected_item() -> void:
	selected_item = ""


# Flag management (for puzzle state)
func set_flag(flag_name: String, value: Variant = true) -> void:
	flags[flag_name] = value
	print("[GameManager] Flag set: %s = %s" % [flag_name, value])


func get_flag(flag_name: String, default: Variant = false) -> Variant:
	return flags.get(flag_name, default)


func has_flag(flag_name: String) -> bool:
	return flags.get(flag_name, false) == true


# Room state management
func set_room_state(room_id: String, key: String, value: Variant) -> void:
	if room_id not in room_states:
		room_states[room_id] = {}
	room_states[room_id][key] = value


func get_room_state(room_id: String, key: String, default: Variant = null) -> Variant:
	if room_id in room_states:
		return room_states[room_id].get(key, default)
	return default


# Message display
func show_message(text: String) -> void:
	message_displayed.emit(text)
	print("[Message] %s" % text)


# Interaction handling - called by hotspots/props
func interact(target_id: String, target_name: String) -> void:
	var verb_name := get_verb_text()
	print("[GameManager] Interact: %s %s (item: %s)" % [verb_name, target_name, selected_item])
	interaction_triggered.emit(target_id, VERB_NAMES[current_verb], selected_item)

	# Reset to LOOK after most interactions
	if current_verb != Verb.LOOK:
		await get_tree().create_timer(0.1).timeout
		set_verb(Verb.LOOK)


# Scene transitions
func go_to_room(room_path: String) -> void:
	print("[GameManager] Transitioning to: %s" % room_path)
	get_tree().change_scene_to_file(room_path)
