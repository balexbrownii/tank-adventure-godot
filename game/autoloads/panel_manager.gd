extends Node
## Panel Manager - handles Gorogoa-style panel rearrangement.
## Panels are story "frames" that can be dragged and reordered to change geography/exits.

# ============================================================================
# SIGNALS
# ============================================================================

signal panels_rearranged(puzzle_id: String, new_order: Array[int])
signal connection_made(from_panel: int, to_panel: int, connection_type: String)
signal narrator_reaction(reaction_type: String, message: String)

# ============================================================================
# CONSTANTS
# ============================================================================

## Types of narrator reactions
enum NarratorReaction {
	PROTEST,     ## "Hey! That's not how the story goes!"
	CONFUSION,   ## "Wait, where did the... oh."
	ACCEPTANCE,  ## "Fine. I suppose that works too."
	IMPRESSED,   ## "Huh. I didn't think of that."
	SABOTAGE     ## "If you're going to mess with my story..."
}

# ============================================================================
# STATE
# ============================================================================

## Active panel puzzles
## Format: { "puzzle_id": PanelPuzzleData }
var puzzles: Dictionary = {}

## Current active puzzle (if any)
var active_puzzle_id: String = ""

# ============================================================================
# PUZZLE DATA CLASS
# ============================================================================

class PanelPuzzleData:
	## Unique ID for this puzzle
	var id: String

	## Number of panels in this puzzle
	var panel_count: int

	## Current order of panels (indices)
	var current_order: Array[int]

	## Solution orders that are valid (can have multiple)
	var valid_solutions: Array

	## Connections between panels in each configuration
	## Format: { order_hash: { "exits": {"left": "room_id", "right": "room_id"}, "unlocks": [] } }
	var configurations: Dictionary

	## Whether the puzzle has been solved
	var is_solved: bool = false

	## Narrator reaction messages for this puzzle
	var narrator_messages: Dictionary = {}


	func _init(p_id: String, p_count: int) -> void:
		id = p_id
		panel_count = p_count
		current_order = []
		for i in range(p_count):
			current_order.append(i)
		valid_solutions = []
		configurations = {}


	## Get hash of current order for lookup
	func get_order_hash() -> String:
		return str(current_order)


	## Check if current order matches any valid solution
	func is_valid_solution() -> bool:
		for solution in valid_solutions:
			if current_order == solution:
				return true
		return false

# ============================================================================
# PUZZLE REGISTRATION
# ============================================================================

## Register a new panel puzzle
func register_puzzle(puzzle_id: String, panel_count: int) -> void:
	var puzzle = PanelPuzzleData.new(puzzle_id, panel_count)
	puzzles[puzzle_id] = puzzle


## Add a valid solution order for a puzzle
func add_solution(puzzle_id: String, order: Array[int]) -> void:
	if puzzle_id not in puzzles:
		push_error("PanelManager: Unknown puzzle '%s'" % puzzle_id)
		return
	puzzles[puzzle_id].valid_solutions.append(order)


## Add configuration data for a specific order
func add_configuration(puzzle_id: String, order: Array[int], exits: Dictionary, unlocks: Array[String] = []) -> void:
	if puzzle_id not in puzzles:
		push_error("PanelManager: Unknown puzzle '%s'" % puzzle_id)
		return

	var order_hash = str(order)
	puzzles[puzzle_id].configurations[order_hash] = {
		"exits": exits,
		"unlocks": unlocks
	}


## Add narrator messages for a puzzle
func add_narrator_messages(puzzle_id: String, messages: Dictionary) -> void:
	if puzzle_id not in puzzles:
		return
	puzzles[puzzle_id].narrator_messages = messages

# ============================================================================
# PANEL MANIPULATION
# ============================================================================

## Set the active puzzle
func set_active_puzzle(puzzle_id: String) -> bool:
	if puzzle_id not in puzzles:
		return false
	active_puzzle_id = puzzle_id
	return true


## Swap two panels in the active puzzle
func swap_panels(index_a: int, index_b: int) -> bool:
	if active_puzzle_id.is_empty():
		push_error("PanelManager: No active puzzle")
		return false

	var puzzle = puzzles[active_puzzle_id]

	if index_a < 0 or index_a >= puzzle.panel_count:
		return false
	if index_b < 0 or index_b >= puzzle.panel_count:
		return false

	# Swap
	var temp = puzzle.current_order[index_a]
	puzzle.current_order[index_a] = puzzle.current_order[index_b]
	puzzle.current_order[index_b] = temp

	# Emit signal
	panels_rearranged.emit(active_puzzle_id, puzzle.current_order.duplicate())

	# Check for solution
	_check_solution(puzzle)

	# Trigger narrator reaction
	_trigger_narrator_reaction(puzzle)

	print("[PanelManager] Swapped panels %d and %d. New order: %s" % [index_a, index_b, puzzle.current_order])

	return true


## Move a panel to a new position
func move_panel(from_index: int, to_index: int) -> bool:
	if active_puzzle_id.is_empty():
		return false

	var puzzle = puzzles[active_puzzle_id]

	if from_index < 0 or from_index >= puzzle.panel_count:
		return false
	if to_index < 0 or to_index >= puzzle.panel_count:
		return false

	if from_index == to_index:
		return true

	# Remove panel from old position
	var panel = puzzle.current_order[from_index]
	puzzle.current_order.remove_at(from_index)

	# Insert at new position
	puzzle.current_order.insert(to_index, panel)

	# Emit signal
	panels_rearranged.emit(active_puzzle_id, puzzle.current_order.duplicate())

	# Check for solution
	_check_solution(puzzle)

	# Trigger narrator reaction
	_trigger_narrator_reaction(puzzle)

	print("[PanelManager] Moved panel from %d to %d. New order: %s" % [from_index, to_index, puzzle.current_order])

	return true


## Set order directly
func set_order(puzzle_id: String, order: Array[int]) -> bool:
	if puzzle_id not in puzzles:
		return false

	var puzzle = puzzles[puzzle_id]

	if order.size() != puzzle.panel_count:
		return false

	puzzle.current_order = order.duplicate()

	panels_rearranged.emit(puzzle_id, puzzle.current_order.duplicate())
	_check_solution(puzzle)

	return true

# ============================================================================
# SOLUTION CHECKING
# ============================================================================

func _check_solution(puzzle: PanelPuzzleData) -> void:
	if puzzle.is_valid_solution() and not puzzle.is_solved:
		puzzle.is_solved = true
		print("[PanelManager] Puzzle '%s' solved!" % puzzle.id)

		# Apply configuration effects
		var config = get_current_configuration(puzzle.id)
		if config and config.has("unlocks"):
			for flag in config.unlocks:
				GameState.set_flag(flag, true)


func _trigger_narrator_reaction(puzzle: PanelPuzzleData) -> void:
	# Check if we have narrator messages for this puzzle
	if puzzle.narrator_messages.is_empty():
		return

	var reaction_type: String
	var message: String

	if puzzle.is_valid_solution():
		reaction_type = "impressed" if puzzle.narrator_messages.has("impressed") else "acceptance"
		message = puzzle.narrator_messages.get(reaction_type, "...Fine.")
	else:
		# Random protest or confusion
		var reactions = ["protest", "confusion"]
		reaction_type = reactions[randi() % reactions.size()]
		message = puzzle.narrator_messages.get(reaction_type, "That's not right...")

	narrator_reaction.emit(reaction_type, message)
	print("[PanelManager] Narrator: [%s] %s" % [reaction_type, message])

# ============================================================================
# CONFIGURATION ACCESS
# ============================================================================

## Get exits available with current panel configuration
func get_current_configuration(puzzle_id: String) -> Dictionary:
	if puzzle_id not in puzzles:
		return {}

	var puzzle = puzzles[puzzle_id]
	var order_hash = puzzle.get_order_hash()

	return puzzle.configurations.get(order_hash, {})


## Get available exits for current order
func get_current_exits(puzzle_id: String) -> Dictionary:
	var config = get_current_configuration(puzzle_id)
	return config.get("exits", {})


## Check if a specific exit is available
func has_exit(puzzle_id: String, direction: String) -> bool:
	var exits = get_current_exits(puzzle_id)
	return exits.has(direction) and exits[direction] != ""


## Get destination for an exit
func get_exit_destination(puzzle_id: String, direction: String) -> String:
	var exits = get_current_exits(puzzle_id)
	return exits.get(direction, "")

# ============================================================================
# UTILITY
# ============================================================================

## Get current order for a puzzle
func get_current_order(puzzle_id: String) -> Array[int]:
	if puzzle_id not in puzzles:
		return []
	return puzzles[puzzle_id].current_order.duplicate()


## Check if puzzle is solved
func is_puzzle_solved(puzzle_id: String) -> bool:
	if puzzle_id not in puzzles:
		return false
	return puzzles[puzzle_id].is_solved


## Reset a puzzle to default order
func reset_puzzle(puzzle_id: String) -> void:
	if puzzle_id not in puzzles:
		return

	var puzzle = puzzles[puzzle_id]
	puzzle.current_order.clear()
	for i in range(puzzle.panel_count):
		puzzle.current_order.append(i)
	puzzle.is_solved = false

	panels_rearranged.emit(puzzle_id, puzzle.current_order.duplicate())


## Clear all puzzles
func clear() -> void:
	puzzles.clear()
	active_puzzle_id = ""

# ============================================================================
# SAVE/LOAD
# ============================================================================

func save_state() -> Dictionary:
	var saved := {}
	for pid in puzzles:
		saved[pid] = {
			"current_order": puzzles[pid].current_order,
			"is_solved": puzzles[pid].is_solved
		}
	return saved


func load_state(data: Dictionary) -> void:
	for pid in data:
		if pid in puzzles:
			puzzles[pid].current_order = data[pid].get("current_order", puzzles[pid].current_order)
			puzzles[pid].is_solved = data[pid].get("is_solved", false)
