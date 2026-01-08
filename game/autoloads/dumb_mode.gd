extends Node
## Tracks player choices between "smart" and "dumb" solutions throughout the game.
## Tank's dumbness is the core humor mechanic - this system enables tracking
## which path players take and unlocks achievements for going "full dumb."

signal dumb_choice_made(choice_id: String)
signal smart_choice_made(choice_id: String)

## All dumb choices the player has made this playthrough
var dumb_choices_made: Array[String] = []

## All smart choices the player has made this playthrough
var smart_choices_made: Array[String] = []

## Current streak of consecutive dumb choices
var current_dumb_streak: int = 0

## Highest dumb streak achieved this playthrough
var max_dumb_streak: int = 0


func _ready() -> void:
	# Load saved choices if continuing a game
	_load_choices()


## Register a dumb choice (Tank-logic solution)
func register_dumb_choice(choice_id: String) -> void:
	if choice_id in dumb_choices_made:
		return  # Already made this choice

	dumb_choices_made.append(choice_id)
	current_dumb_streak += 1

	if current_dumb_streak > max_dumb_streak:
		max_dumb_streak = current_dumb_streak

	dumb_choice_made.emit(choice_id)
	_save_choices()

	# Check for achievements
	_check_achievements()


## Register a smart choice (logical solution)
func register_smart_choice(choice_id: String) -> void:
	if choice_id in smart_choices_made:
		return  # Already made this choice

	smart_choices_made.append(choice_id)
	current_dumb_streak = 0  # Breaks the dumb streak

	smart_choice_made.emit(choice_id)
	_save_choices()


## Check if player made a specific dumb choice
func made_dumb_choice(choice_id: String) -> bool:
	return choice_id in dumb_choices_made


## Check if player made a specific smart choice
func made_smart_choice(choice_id: String) -> bool:
	return choice_id in smart_choices_made


## Check if any choice was made for a given decision point
func made_choice(choice_id: String) -> bool:
	return made_dumb_choice(choice_id) or made_smart_choice(choice_id)


## Get total number of dumb choices made
func get_dumb_count() -> int:
	return dumb_choices_made.size()


## Get total number of smart choices made
func get_smart_count() -> int:
	return smart_choices_made.size()


## Check if player has achieved "Maximum Tank" status (all dumb choices)
func is_maximum_tank() -> bool:
	return dumb_choices_made.size() >= 20 and smart_choices_made.size() == 0


## Check if player is on a dumb streak of at least n choices
func on_dumb_streak(min_streak: int) -> bool:
	return current_dumb_streak >= min_streak


## Reset all choices (for new game)
func reset_choices() -> void:
	dumb_choices_made.clear()
	smart_choices_made.clear()
	current_dumb_streak = 0
	max_dumb_streak = 0
	_save_choices()


## Save choices to disk
func _save_choices() -> void:
	var save_data := {
		"dumb_choices": dumb_choices_made,
		"smart_choices": smart_choices_made,
		"current_streak": current_dumb_streak,
		"max_streak": max_dumb_streak
	}

	var save_file := FileAccess.open("user://dumb_mode_save.json", FileAccess.WRITE)
	if save_file:
		save_file.store_string(JSON.stringify(save_data))
		save_file.close()


## Load choices from disk
func _load_choices() -> void:
	if not FileAccess.file_exists("user://dumb_mode_save.json"):
		return

	var save_file := FileAccess.open("user://dumb_mode_save.json", FileAccess.READ)
	if not save_file:
		return

	var json := JSON.new()
	var parse_result := json.parse(save_file.get_as_text())
	save_file.close()

	if parse_result != OK:
		return

	var data: Dictionary = json.data

	# Convert arrays back to typed arrays
	dumb_choices_made.clear()
	for choice in data.get("dumb_choices", []):
		dumb_choices_made.append(choice)

	smart_choices_made.clear()
	for choice in data.get("smart_choices", []):
		smart_choices_made.append(choice)

	current_dumb_streak = data.get("current_streak", 0)
	max_dumb_streak = data.get("max_streak", 0)


## Check and trigger achievements based on current state
func _check_achievements() -> void:
	# These can be expanded with actual achievement system later
	if is_maximum_tank():
		print("[DumbMode] Achievement unlocked: MAXIMUM TANK!")
	elif current_dumb_streak >= 10:
		print("[DumbMode] Achievement unlocked: Tank Brain (10 dumb choices in a row)")
	elif current_dumb_streak >= 5:
		print("[DumbMode] Achievement unlocked: Thinking Like Tank (5 dumb choices in a row)")
