extends Node
## Tank Vision system - toggles between Tank's misperceived reality and actual reality.
## This is a core mechanic where Tank sees things "wrong" but the player can peek at truth.

# ============================================================================
# SIGNALS
# ============================================================================

signal vision_mode_changed(new_mode: VisionMode)
signal tank_told(topic: String)

# ============================================================================
# ENUMS
# ============================================================================

## The two ways of seeing the world
enum VisionMode {
	TANK,    ## Tank's misperceptions - funny, wrong labels
	REALITY  ## Actual truth - useful for puzzles
}

# ============================================================================
# STATE
# ============================================================================

## Current vision mode
var current_mode: VisionMode = VisionMode.TANK:
	set(value):
		if current_mode != value:
			current_mode = value
			vision_mode_changed.emit(current_mode)

## Topics Tank has been "told" about (Reality → Tank knowledge)
## Format: { "topic_id": true }
var told_topics: Dictionary = {}

# ============================================================================
# LIFECYCLE
# ============================================================================

func _ready() -> void:
	# Load told_topics from GameState if available
	if GameState:
		told_topics = GameState.story_flags.get("told_topics", {})


func _input(event: InputEvent) -> void:
	# Toggle vision on Tab key or custom input
	if event.is_action_pressed("toggle_vision"):
		toggle_vision()

# ============================================================================
# VISION MODE API
# ============================================================================

## Toggle between Tank and Reality vision
func toggle_vision() -> void:
	if current_mode == VisionMode.TANK:
		current_mode = VisionMode.REALITY
	else:
		current_mode = VisionMode.TANK


## Check if we're in Tank's confused vision
func is_tank_vision() -> bool:
	return current_mode == VisionMode.TANK


## Check if we're seeing reality
func is_reality_vision() -> bool:
	return current_mode == VisionMode.REALITY


## Set vision mode directly
func set_vision_mode(mode: VisionMode) -> void:
	current_mode = mode

# ============================================================================
# HOTSPOT DATA STORAGE
# ============================================================================

## Registered hotspot data per room
## Format: { "room_name": { "hotspot_id": { vision_data } } }
var _hotspot_registry: Dictionary = {}


## Register vision data for a hotspot
func register_hotspot_data(room_name: String, hotspot_id: String, data: Dictionary) -> void:
	if not room_name in _hotspot_registry:
		_hotspot_registry[room_name] = {}
	_hotspot_registry[room_name][hotspot_id] = data


## Get registered vision data for a hotspot
func get_hotspot_data(room_name: String, hotspot_id: String) -> Dictionary:
	if room_name in _hotspot_registry:
		return _hotspot_registry[room_name].get(hotspot_id, {})
	return {}


## Clear hotspot data for a room (called on room exit)
func clear_room_hotspots(room_name: String) -> void:
	_hotspot_registry.erase(room_name)


# ============================================================================
# HOTSPOT LABEL API
# ============================================================================

## Get the appropriate hover label for a hotspot based on current vision
## hotspot_data should have: tank_hover, tank_inspect, reality_hover, reality_inspect
func get_hover_label(hotspot_data: Dictionary) -> String:
	if current_mode == VisionMode.TANK:
		return hotspot_data.get("tank_hover", "???")
	else:
		return hotspot_data.get("reality_hover", "???")


## Get the appropriate inspect text for a hotspot based on current vision
func get_inspect_text(hotspot_data: Dictionary) -> String:
	if current_mode == VisionMode.TANK:
		return hotspot_data.get("tank_inspect", "I see... something.")
	else:
		return hotspot_data.get("reality_inspect", "It's a thing.")


## Get hover label with support for VisionHotspotData resource
func get_label(hotspot: Node) -> String:
	if hotspot.has_method("get_vision_data"):
		var data = hotspot.get_vision_data()
		return get_hover_label(data)
	return hotspot.name

# ============================================================================
# "TELL TANK" SYSTEM
# ============================================================================

## Tell Tank the truth about something.
## This converts Reality knowledge into Tank knowledge, which can:
## - Remove certain "dumb luck" options
## - Change future dialogue
## - Permanently affect the Ignorance meter
func tell_tank(topic: String) -> void:
	if topic in told_topics:
		return  # Already told

	told_topics[topic] = true

	# Decrease ignorance - Tank is learning!
	if GameState:
		GameState.modify_ignorance(-10)
		GameState.learn_truth(topic)
		# Store told_topics in GameState for persistence
		GameState.set_flag("told_topics", told_topics)

	tank_told.emit(topic)
	print("[TankVision] Tank was told about: %s" % topic)


## Check if Tank has been told about a topic
func was_tank_told(topic: String) -> bool:
	return told_topics.get(topic, false)


## Check if a "dumb option" is still available
## Dumb options require Tank to NOT know the truth
func is_dumb_option_available(required_ignorance_topic: String) -> bool:
	return not was_tank_told(required_ignorance_topic)


## Get list of available dumb options based on what Tank still doesn't know
func get_available_dumb_options(options: Array[String]) -> Array[String]:
	var available: Array[String] = []
	for option in options:
		if is_dumb_option_available(option):
			available.append(option)
	return available

# ============================================================================
# SAVE/LOAD
# ============================================================================

func save_state() -> Dictionary:
	return {
		"current_mode": current_mode,
		"told_topics": told_topics
	}


func load_state(data: Dictionary) -> void:
	current_mode = data.get("current_mode", VisionMode.TANK)
	told_topics = data.get("told_topics", {})
