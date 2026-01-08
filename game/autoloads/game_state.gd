extends Node
## Central game state manager for Tank's Great Adventure.
## Handles: Approach tracking, consequence meters, episode state, party composition.

# ============================================================================
# SIGNALS
# ============================================================================

signal approach_used(approach: Approach, puzzle_id: String)
signal heat_changed(old_value: int, new_value: int)
signal ignorance_changed(old_value: int, new_value: int)
signal morale_changed(old_value: int, new_value: int)
signal party_member_joined(character_id: String)
signal episode_changed(episode: int)

# ============================================================================
# ENUMS
# ============================================================================

## The three approaches to solving puzzles
enum Approach {
	BRAINS,   ## Pig's way: craft, bargain, sneak, misdirect
	BRAWN,    ## Tank's way: smash, throw, intimidate, martial arts
	BIZARRE   ## Meta way: UI breaks, page tears, literal idioms
}

## Character kits - abilities available per character
enum CharacterKit {
	# Tank's kit
	LIFT,
	SMASH,
	INTIMIDATE,
	CONFIDENTLY_WRONG,
	# Pig's kit
	TALK,
	CRAFT,
	PLAN,
	SCHEME,
	# Mr. Snuggles' kit
	REACH,
	CARRY_QUIETLY,
	SPRINT_BURST,
	LOOK_INNOCENT
}

# ============================================================================
# CONSEQUENCE METERS (0-100 scale)
# ============================================================================

## Heat: How wanted/pursued Tank is. Higher = more guards, less NPC cooperation.
var heat: int = 0:
	set(value):
		var old = heat
		heat = clampi(value, 0, 100)
		if old != heat:
			heat_changed.emit(old, heat)
			_save_state()

## Ignorance: How much Tank doesn't know about reality.
## Higher = more chaotic options available. Learning truth REDUCES options.
var ignorance: int = 100:
	set(value):
		var old = ignorance
		ignorance = clampi(value, 0, 100)
		if old != ignorance:
			ignorance_changed.emit(old, ignorance)
			_save_state()

## Morale: Pig's patience + Mr. Snuggles' cooperation.
## Lower = fewer hints, less cooperation from party.
var morale: int = 100:
	set(value):
		var old = morale
		morale = clampi(value, 0, 100)
		if old != morale:
			morale_changed.emit(old, morale)
			_save_state()

# ============================================================================
# APPROACH TRACKING
# ============================================================================

## Puzzles solved via each approach
var brains_solutions: Array[String] = []
var brawn_solutions: Array[String] = []
var bizarre_solutions: Array[String] = []

## Current approach streak
var current_approach_streak: Dictionary = {
	Approach.BRAINS: 0,
	Approach.BRAWN: 0,
	Approach.BIZARRE: 0
}

# ============================================================================
# EPISODE & PROGRESS STATE
# ============================================================================

## Current episode (0-8)
var current_episode: int = 0:
	set(value):
		current_episode = clampi(value, 0, 8)
		episode_changed.emit(current_episode)
		_save_state()

## Puzzle completion flags (puzzle_id -> approach used)
var completed_puzzles: Dictionary = {}

## Story flags (arbitrary key-value for story state)
var story_flags: Dictionary = {}

# ============================================================================
# PARTY STATE
# ============================================================================

## Characters currently in party
var party_members: Array[String] = ["tank"]  # Tank always in party

## Active character being controlled
var active_character: String = "tank"

# ============================================================================
# HINT SYSTEM
# ============================================================================

## Hint tokens earned through banter triggers
var hint_tokens: int = 0

## Hints used per puzzle (to track tier progression)
var hints_used: Dictionary = {}

# ============================================================================
# LIFECYCLE
# ============================================================================

func _ready() -> void:
	_load_state()


# ============================================================================
# APPROACH WHEEL API
# ============================================================================

## Register solving a puzzle via a specific approach
func solve_puzzle(puzzle_id: String, approach: Approach) -> void:
	if puzzle_id in completed_puzzles:
		return  # Already solved

	completed_puzzles[puzzle_id] = approach

	match approach:
		Approach.BRAINS:
			brains_solutions.append(puzzle_id)
			_reset_streaks_except(Approach.BRAINS)
			current_approach_streak[Approach.BRAINS] += 1
			# Brains solutions typically lower heat
			heat -= 5
		Approach.BRAWN:
			brawn_solutions.append(puzzle_id)
			_reset_streaks_except(Approach.BRAWN)
			current_approach_streak[Approach.BRAWN] += 1
			# Brawn solutions typically raise heat
			heat += 10
		Approach.BIZARRE:
			bizarre_solutions.append(puzzle_id)
			_reset_streaks_except(Approach.BIZARRE)
			current_approach_streak[Approach.BIZARRE] += 1

	approach_used.emit(approach, puzzle_id)
	_save_state()
	_check_approach_achievements()


func _reset_streaks_except(keep: Approach) -> void:
	for a in current_approach_streak.keys():
		if a != keep:
			current_approach_streak[a] = 0


## Check if a puzzle was solved
func is_puzzle_solved(puzzle_id: String) -> bool:
	return puzzle_id in completed_puzzles


## Get which approach was used for a puzzle
func get_puzzle_approach(puzzle_id: String) -> Approach:
	return completed_puzzles.get(puzzle_id, Approach.BRAINS)


## Get count of puzzles solved by approach
func get_approach_count(approach: Approach) -> int:
	match approach:
		Approach.BRAINS: return brains_solutions.size()
		Approach.BRAWN: return brawn_solutions.size()
		Approach.BIZARRE: return bizarre_solutions.size()
	return 0


# ============================================================================
# CONSEQUENCE METER API
# ============================================================================

## Modify heat (positive = more wanted, negative = cooling off)
func modify_heat(delta: int) -> void:
	heat += delta


## Modify ignorance (positive = more ignorant, negative = learning truth)
## Warning: Learning truth can lock out chaotic options!
func modify_ignorance(delta: int) -> void:
	ignorance += delta


## Modify morale (positive = happier party, negative = frustrated party)
func modify_morale(delta: int) -> void:
	morale += delta


## Check if Tank still believes something false (enables Bizarre options)
func is_ignorant_of(topic: String) -> bool:
	return not story_flags.get("learned_" + topic, false)


## Tank learns the truth about something (may disable options!)
func learn_truth(topic: String) -> void:
	story_flags["learned_" + topic] = true
	ignorance -= 10
	_save_state()


# ============================================================================
# PARTY MANAGEMENT API
# ============================================================================

## Add a character to the party
func add_party_member(character_id: String) -> void:
	if character_id not in party_members:
		party_members.append(character_id)
		party_member_joined.emit(character_id)
		_save_state()


## Check if character is in party
func has_party_member(character_id: String) -> bool:
	return character_id in party_members


## Switch active character
func switch_character(character_id: String) -> bool:
	if character_id in party_members:
		active_character = character_id
		return true
	return false


## Get available kits based on active character
func get_available_kits() -> Array[CharacterKit]:
	var kits: Array[CharacterKit] = []
	match active_character:
		"tank":
			kits = [CharacterKit.LIFT, CharacterKit.SMASH,
					CharacterKit.INTIMIDATE, CharacterKit.CONFIDENTLY_WRONG]
		"pig":
			kits = [CharacterKit.TALK, CharacterKit.CRAFT,
					CharacterKit.PLAN, CharacterKit.SCHEME]
		"mr_snuggles":
			kits = [CharacterKit.REACH, CharacterKit.CARRY_QUIETLY,
					CharacterKit.SPRINT_BURST, CharacterKit.LOOK_INNOCENT]
	return kits


# ============================================================================
# HINT SYSTEM API
# ============================================================================

## Award hint tokens (e.g., from banter triggers)
func award_hint_tokens(amount: int) -> void:
	hint_tokens += amount
	_save_state()


## Get current hint tier available for a puzzle (0 = none used, 1-3 = tiers)
func get_hint_tier_used(puzzle_id: String) -> int:
	return hints_used.get(puzzle_id, 0)


## Request a hint for a puzzle. Returns tier granted (0 if denied).
func request_hint(puzzle_id: String) -> int:
	var current_tier = get_hint_tier_used(puzzle_id)

	if current_tier >= 3:
		return 0  # All hints used

	var next_tier = current_tier + 1

	# Tier 1 is always free
	if next_tier == 1:
		hints_used[puzzle_id] = 1
		_save_state()
		return 1

	# Tier 2 costs 1 token
	if next_tier == 2:
		if hint_tokens >= 1:
			hint_tokens -= 1
			hints_used[puzzle_id] = 2
			_save_state()
			return 2
		return 0  # Can't afford

	# Tier 3 costs 2 tokens
	if next_tier == 3:
		if hint_tokens >= 2:
			hint_tokens -= 2
			hints_used[puzzle_id] = 3
			_save_state()
			return 3
		return 0  # Can't afford

	return 0


# ============================================================================
# STORY FLAGS API
# ============================================================================

## Set a story flag
func set_flag(flag_id: String, value: Variant = true) -> void:
	story_flags[flag_id] = value
	_save_state()


## Get a story flag
func get_flag(flag_id: String, default: Variant = null) -> Variant:
	return story_flags.get(flag_id, default)


## Check if a flag is set (truthy)
func has_flag(flag_id: String) -> bool:
	return story_flags.get(flag_id, false) == true


# ============================================================================
# ACHIEVEMENT CHECKS
# ============================================================================

## All Brawn solutions
func is_maximum_tank() -> bool:
	return brawn_solutions.size() >= 20 and brains_solutions.size() == 0 and bizarre_solutions.size() == 0


## All Brains solutions
func is_pigs_pride() -> bool:
	return brains_solutions.size() >= 20 and brawn_solutions.size() == 0 and bizarre_solutions.size() == 0


## All Bizarre solutions
func is_what_just_happened() -> bool:
	return bizarre_solutions.size() >= 20 and brains_solutions.size() == 0 and brawn_solutions.size() == 0


## Balanced approach
func is_perfectly_balanced() -> bool:
	var total = brains_solutions.size() + brawn_solutions.size() + bizarre_solutions.size()
	if total < 15:
		return false
	var avg = total / 3.0
	var brains_diff = absf(brains_solutions.size() - avg)
	var brawn_diff = absf(brawn_solutions.size() - avg)
	var bizarre_diff = absf(bizarre_solutions.size() - avg)
	return brains_diff <= 3 and brawn_diff <= 3 and bizarre_diff <= 3


func _check_approach_achievements() -> void:
	if is_maximum_tank():
		print("[GameState] Achievement: MAXIMUM TANK!")
	if is_pigs_pride():
		print("[GameState] Achievement: Pig's Pride!")
	if is_what_just_happened():
		print("[GameState] Achievement: What Just Happened?!")
	if is_perfectly_balanced():
		print("[GameState] Achievement: Perfectly Balanced!")


# ============================================================================
# SAVE/LOAD
# ============================================================================

const SAVE_PATH = "user://game_state.json"

func _save_state() -> void:
	var data := {
		"heat": heat,
		"ignorance": ignorance,
		"morale": morale,
		"current_episode": current_episode,
		"brains_solutions": brains_solutions,
		"brawn_solutions": brawn_solutions,
		"bizarre_solutions": bizarre_solutions,
		"completed_puzzles": completed_puzzles,
		"story_flags": story_flags,
		"party_members": party_members,
		"active_character": active_character,
		"hint_tokens": hint_tokens,
		"hints_used": hints_used
	}

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))
		file.close()


func _load_state() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return

	var json := JSON.new()
	if json.parse(file.get_as_text()) != OK:
		file.close()
		return
	file.close()

	var data: Dictionary = json.data

	heat = data.get("heat", 0)
	ignorance = data.get("ignorance", 100)
	morale = data.get("morale", 100)
	current_episode = data.get("current_episode", 0)

	brains_solutions.clear()
	for s in data.get("brains_solutions", []):
		brains_solutions.append(s)

	brawn_solutions.clear()
	for s in data.get("brawn_solutions", []):
		brawn_solutions.append(s)

	bizarre_solutions.clear()
	for s in data.get("bizarre_solutions", []):
		bizarre_solutions.append(s)

	completed_puzzles = data.get("completed_puzzles", {})
	story_flags = data.get("story_flags", {})

	party_members.clear()
	for m in data.get("party_members", ["tank"]):
		party_members.append(m)

	active_character = data.get("active_character", "tank")
	hint_tokens = data.get("hint_tokens", 0)
	hints_used = data.get("hints_used", {})


## Reset all state for new game
func new_game() -> void:
	heat = 0
	ignorance = 100
	morale = 100
	current_episode = 0
	brains_solutions.clear()
	brawn_solutions.clear()
	bizarre_solutions.clear()
	completed_puzzles.clear()
	story_flags.clear()
	party_members = ["tank"]
	active_character = "tank"
	hint_tokens = 0
	hints_used.clear()
	_save_state()
