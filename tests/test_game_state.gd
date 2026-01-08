extends Node
## Unit tests for GameState autoload
## Run from Godot editor: Scene > Run Script or attach to a test scene

var tests_passed := 0
var tests_failed := 0


func _ready() -> void:
	print("\n=== GAMESTATE UNIT TESTS ===\n")

	# Ensure clean state
	GameState.new_game()

	# Run tests
	test_meter_defaults()
	test_meter_clamping()
	test_meter_signals()
	test_approach_tracking()
	test_party_management()
	test_hint_system()
	test_save_load()

	# Report
	print("\n=== RESULTS ===")
	print("Passed: %d" % tests_passed)
	print("Failed: %d" % tests_failed)
	print("Total: %d" % (tests_passed + tests_failed))

	if tests_failed == 0:
		print("\nALL TESTS PASSED!")
	else:
		print("\nSOME TESTS FAILED - see above for details")

	# Exit after tests complete (for headless mode)
	await get_tree().process_frame
	get_tree().quit(tests_failed)


func assert_eq(actual: Variant, expected: Variant, test_name: String) -> void:
	if actual == expected:
		tests_passed += 1
		print("[PASS] %s" % test_name)
	else:
		tests_failed += 1
		print("[FAIL] %s - Expected: %s, Got: %s" % [test_name, expected, actual])


func assert_true(condition: bool, test_name: String) -> void:
	if condition:
		tests_passed += 1
		print("[PASS] %s" % test_name)
	else:
		tests_failed += 1
		print("[FAIL] %s - Expected: true, Got: false" % test_name)


func assert_false(condition: bool, test_name: String) -> void:
	if not condition:
		tests_passed += 1
		print("[PASS] %s" % test_name)
	else:
		tests_failed += 1
		print("[FAIL] %s - Expected: false, Got: true" % test_name)


# ----------------------------------------------------------------------------
# TEST: Meter Defaults
# ----------------------------------------------------------------------------

func test_meter_defaults() -> void:
	print("\n--- Meter Defaults ---")
	GameState.new_game()

	assert_eq(GameState.heat, 0, "Heat starts at 0")
	assert_eq(GameState.ignorance, 100, "Ignorance starts at 100")
	assert_eq(GameState.morale, 100, "Morale starts at 100")


# ----------------------------------------------------------------------------
# TEST: Meter Clamping (0-100)
# ----------------------------------------------------------------------------

func test_meter_clamping() -> void:
	print("\n--- Meter Clamping ---")
	GameState.new_game()

	# Test upper bound
	GameState.heat = 150
	assert_eq(GameState.heat, 100, "Heat clamps at 100 (upper)")

	GameState.ignorance = 200
	assert_eq(GameState.ignorance, 100, "Ignorance clamps at 100 (upper)")

	GameState.morale = 999
	assert_eq(GameState.morale, 100, "Morale clamps at 100 (upper)")

	# Test lower bound
	GameState.heat = -50
	assert_eq(GameState.heat, 0, "Heat clamps at 0 (lower)")

	GameState.ignorance = -100
	assert_eq(GameState.ignorance, 0, "Ignorance clamps at 0 (lower)")

	GameState.morale = -1
	assert_eq(GameState.morale, 0, "Morale clamps at 0 (lower)")

	# Test valid values stay valid
	GameState.new_game()
	GameState.heat = 50
	assert_eq(GameState.heat, 50, "Heat accepts valid value 50")

	GameState.modify_heat(25)
	assert_eq(GameState.heat, 75, "modify_heat(25) adds correctly")


# ----------------------------------------------------------------------------
# TEST: Meter Signals
# ----------------------------------------------------------------------------

func test_meter_signals() -> void:
	print("\n--- Meter Signals ---")
	GameState.new_game()

	# Test signals by checking connection count works
	var signal_count := 0
	var on_signal = func(_a, _b): signal_count += 1

	GameState.heat_changed.connect(on_signal)
	GameState.ignorance_changed.connect(on_signal)
	GameState.morale_changed.connect(on_signal)

	# Reset to known state, then change
	GameState.heat = 0
	GameState.ignorance = 100
	GameState.morale = 100
	signal_count = 0  # Reset after setup

	# Now make actual changes
	GameState.heat = 10  # Should emit
	GameState.ignorance = 90  # Should emit
	GameState.morale = 80  # Should emit

	# Verify signals fired (3 total)
	assert_eq(signal_count, 3, "All meter signals emit on change")

	# Test no emit when value unchanged
	signal_count = 0
	GameState.heat = 10  # Same value
	assert_eq(signal_count, 0, "No signal when value unchanged")

	# Test emit on different value
	GameState.heat = 20
	assert_eq(signal_count, 1, "Signal emits on new value")

	# Disconnect
	GameState.heat_changed.disconnect(on_signal)
	GameState.ignorance_changed.disconnect(on_signal)
	GameState.morale_changed.disconnect(on_signal)


# ----------------------------------------------------------------------------
# TEST: Approach Tracking
# ----------------------------------------------------------------------------

func test_approach_tracking() -> void:
	print("\n--- Approach Tracking ---")
	GameState.new_game()

	# Solve a puzzle with Brains
	GameState.solve_puzzle("test_puzzle_1", GameState.Approach.BRAINS)
	assert_true(GameState.is_puzzle_solved("test_puzzle_1"), "Puzzle marked as solved")
	assert_eq(GameState.get_puzzle_approach("test_puzzle_1"), GameState.Approach.BRAINS, "Puzzle approach is BRAINS")
	assert_eq(GameState.get_approach_count(GameState.Approach.BRAINS), 1, "Brains count is 1")

	# Solve with Brawn
	GameState.solve_puzzle("test_puzzle_2", GameState.Approach.BRAWN)
	assert_eq(GameState.get_approach_count(GameState.Approach.BRAWN), 1, "Brawn count is 1")

	# Solve with Bizarre
	GameState.solve_puzzle("test_puzzle_3", GameState.Approach.BIZARRE)
	assert_eq(GameState.get_approach_count(GameState.Approach.BIZARRE), 1, "Bizarre count is 1")

	# Can't solve same puzzle twice
	GameState.solve_puzzle("test_puzzle_1", GameState.Approach.BRAWN)
	assert_eq(GameState.get_approach_count(GameState.Approach.BRAINS), 1, "Can't re-solve same puzzle")

	# Heat changes with approach
	GameState.new_game()
	var initial_heat = GameState.heat
	GameState.solve_puzzle("heat_test_1", GameState.Approach.BRAWN)
	assert_true(GameState.heat > initial_heat, "Brawn increases heat")

	GameState.new_game()
	GameState.heat = 20
	GameState.solve_puzzle("heat_test_2", GameState.Approach.BRAINS)
	assert_true(GameState.heat < 20, "Brains decreases heat")


# ----------------------------------------------------------------------------
# TEST: Party Management
# ----------------------------------------------------------------------------

func test_party_management() -> void:
	print("\n--- Party Management ---")
	GameState.new_game()

	# Tank always in party
	assert_true(GameState.has_party_member("tank"), "Tank in party by default")
	assert_eq(GameState.active_character, "tank", "Tank is active by default")

	# Add party members
	GameState.add_party_member("pig")
	assert_true(GameState.has_party_member("pig"), "Pig added to party")

	GameState.add_party_member("mr_snuggles")
	assert_true(GameState.has_party_member("mr_snuggles"), "Mr. Snuggles added to party")

	# Switch characters
	assert_true(GameState.switch_character("pig"), "Can switch to Pig")
	assert_eq(GameState.active_character, "pig", "Active character is now Pig")

	# Can't switch to non-party member
	assert_false(GameState.switch_character("wolf"), "Can't switch to non-party member")

	# Character kits
	GameState.switch_character("tank")
	var tank_kits = GameState.get_available_kits()
	assert_true(GameState.CharacterKit.SMASH in tank_kits, "Tank has SMASH kit")

	GameState.switch_character("pig")
	var pig_kits = GameState.get_available_kits()
	assert_true(GameState.CharacterKit.CRAFT in pig_kits, "Pig has CRAFT kit")


# ----------------------------------------------------------------------------
# TEST: Hint System
# ----------------------------------------------------------------------------

func test_hint_system() -> void:
	print("\n--- Hint System ---")
	GameState.new_game()

	# Tier 1 is always free
	var tier = GameState.request_hint("hint_test_puzzle")
	assert_eq(tier, 1, "Tier 1 hint is free")
	assert_eq(GameState.get_hint_tier_used("hint_test_puzzle"), 1, "Hint tier tracked")

	# Tier 2 requires tokens
	tier = GameState.request_hint("hint_test_puzzle")
	assert_eq(tier, 0, "Tier 2 denied without tokens")

	GameState.award_hint_tokens(1)
	tier = GameState.request_hint("hint_test_puzzle")
	assert_eq(tier, 2, "Tier 2 granted with token")
	assert_eq(GameState.hint_tokens, 0, "Token consumed")

	# Tier 3 requires 2 tokens
	GameState.award_hint_tokens(2)
	tier = GameState.request_hint("hint_test_puzzle")
	assert_eq(tier, 3, "Tier 3 granted with 2 tokens")
	assert_eq(GameState.hint_tokens, 0, "2 tokens consumed")

	# Max tier reached
	tier = GameState.request_hint("hint_test_puzzle")
	assert_eq(tier, 0, "No more hints after tier 3")


# ----------------------------------------------------------------------------
# TEST: Save/Load
# ----------------------------------------------------------------------------

func test_save_load() -> void:
	print("\n--- Save/Load ---")

	# Set up specific state
	GameState.new_game()
	GameState.heat = 42
	GameState.ignorance = 73
	GameState.morale = 88
	GameState.current_episode = 3
	GameState.solve_puzzle("save_test_puzzle", GameState.Approach.BIZARRE)
	GameState.add_party_member("pig")
	GameState.set_flag("test_flag", "test_value")
	GameState.award_hint_tokens(5)

	# Force save (already saved by setters, but be explicit)
	GameState._save_state()

	# Save file path for verification
	var save_path = GameState.SAVE_PATH

	# Verify save file exists
	assert_true(FileAccess.file_exists(save_path), "Save file exists")

	# Read saved values directly from file to verify persistence
	var file := FileAccess.open(save_path, FileAccess.READ)
	if file:
		var json := JSON.new()
		json.parse(file.get_as_text())
		file.close()
		var data: Dictionary = json.data

		assert_eq(data.get("heat", -1), 42, "Heat saved to file correctly")
		assert_eq(data.get("ignorance", -1), 73, "Ignorance saved to file correctly")
		assert_eq(data.get("morale", -1), 88, "Morale saved to file correctly")
		assert_eq(data.get("current_episode", -1), 3, "Episode saved to file correctly")
		assert_true("save_test_puzzle" in data.get("completed_puzzles", {}), "Puzzles saved to file")
		assert_true("pig" in data.get("party_members", []), "Party saved to file")
		assert_eq(data.get("story_flags", {}).get("test_flag"), "test_value", "Flags saved to file")
		assert_eq(data.get("hint_tokens", -1), 5, "Hint tokens saved to file")
	else:
		tests_failed += 8
		print("[FAIL] Could not read save file")

	# Test that new_game resets values (separate from load test)
	GameState.heat = 99
	GameState.ignorance = 50
	GameState.new_game()
	assert_eq(GameState.heat, 0, "new_game() resets heat")
	assert_eq(GameState.ignorance, 100, "new_game() resets ignorance")

	# Test _load_state restores from file
	# Write known state directly to save file (bypassing setters)
	var test_save_data := {
		"heat": 77,
		"ignorance": 55,
		"morale": 33,
		"current_episode": 5,
		"brains_solutions": [],
		"brawn_solutions": [],
		"bizarre_solutions": ["load_test_puzzle"],
		"completed_puzzles": {"load_test_puzzle": GameState.Approach.BIZARRE},
		"story_flags": {"load_flag": "load_value"},
		"party_members": ["tank", "pig", "mr_snuggles"],
		"active_character": "pig",
		"hint_tokens": 10,
		"hints_used": {}
	}

	var write_file := FileAccess.open(save_path, FileAccess.WRITE)
	if write_file:
		write_file.store_string(JSON.stringify(test_save_data, "\t"))
		write_file.close()

	# Now load from our test file
	GameState._load_state()

	# Verify restoration from our test file
	assert_eq(GameState.heat, 77, "Heat loaded from file")
	assert_eq(GameState.ignorance, 55, "Ignorance loaded from file")
	assert_eq(GameState.morale, 33, "Morale loaded from file")
	assert_eq(GameState.current_episode, 5, "Episode loaded from file")
	assert_true(GameState.is_puzzle_solved("load_test_puzzle"), "Puzzles loaded from file")
	assert_true(GameState.has_party_member("mr_snuggles"), "Party loaded from file")
	assert_eq(GameState.get_flag("load_flag"), "load_value", "Flags loaded from file")
	assert_eq(GameState.hint_tokens, 10, "Hint tokens loaded from file")
