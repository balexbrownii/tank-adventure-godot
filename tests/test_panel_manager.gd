extends Node
## Unit tests for PanelManager autoload (panel rearrangement)

var tests_passed := 0
var tests_failed := 0


func _ready() -> void:
	print("\n=== PANEL MANAGER UNIT TESTS ===\n")

	# Reset state
	PanelManager.clear()
	GameState.new_game()

	# Run tests
	test_puzzle_registration()
	test_panel_swapping()
	test_panel_moving()
	test_solution_detection()
	test_exits_configuration()
	test_narrator_reactions()

	# Report
	print("\n=== RESULTS ===")
	print("Passed: %d" % tests_passed)
	print("Failed: %d" % tests_failed)
	print("Total: %d" % (tests_passed + tests_failed))

	if tests_failed == 0:
		print("\nALL TESTS PASSED!")
	else:
		print("\nSOME TESTS FAILED - see above for details")

	# Exit
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
# TEST: Puzzle Registration
# ----------------------------------------------------------------------------

func test_puzzle_registration() -> void:
	print("\n--- Puzzle Registration ---")
	PanelManager.clear()

	# Register a 4-panel puzzle
	PanelManager.register_puzzle("gravity_puzzle", 4)

	var order = PanelManager.get_current_order("gravity_puzzle")
	assert_eq(order.size(), 4, "Puzzle has 4 panels")
	assert_eq(order[0], 0, "First panel is 0")
	assert_eq(order[3], 3, "Last panel is 3")

	# Unknown puzzle returns empty
	var empty_order = PanelManager.get_current_order("unknown")
	assert_eq(empty_order.size(), 0, "Unknown puzzle returns empty order")


# ----------------------------------------------------------------------------
# TEST: Panel Swapping
# ----------------------------------------------------------------------------

func test_panel_swapping() -> void:
	print("\n--- Panel Swapping ---")
	PanelManager.clear()

	PanelManager.register_puzzle("swap_test", 3)
	PanelManager.set_active_puzzle("swap_test")

	# Initial order: [0, 1, 2]
	var initial = PanelManager.get_current_order("swap_test")
	assert_eq(initial, [0, 1, 2], "Initial order is 0,1,2")

	# Swap panels 0 and 2
	var result = PanelManager.swap_panels(0, 2)
	assert_true(result, "Swap succeeded")

	var after_swap = PanelManager.get_current_order("swap_test")
	assert_eq(after_swap, [2, 1, 0], "After swap order is 2,1,0")

	# Invalid swap fails
	var bad_swap = PanelManager.swap_panels(-1, 5)
	assert_false(bad_swap, "Invalid swap fails")


# ----------------------------------------------------------------------------
# TEST: Panel Moving
# ----------------------------------------------------------------------------

func test_panel_moving() -> void:
	print("\n--- Panel Moving ---")
	PanelManager.clear()

	PanelManager.register_puzzle("move_test", 4)
	PanelManager.set_active_puzzle("move_test")

	# Initial: [0, 1, 2, 3]
	# Move panel from index 0 to index 2
	PanelManager.move_panel(0, 2)

	var order = PanelManager.get_current_order("move_test")
	assert_eq(order, [1, 2, 0, 3], "Move panel works correctly")

	# Reset and try direct order set
	PanelManager.reset_puzzle("move_test")
	var reset_order = PanelManager.get_current_order("move_test")
	assert_eq(reset_order, [0, 1, 2, 3], "Reset restores default order")


# ----------------------------------------------------------------------------
# TEST: Solution Detection
# ----------------------------------------------------------------------------

func test_solution_detection() -> void:
	print("\n--- Solution Detection ---")
	PanelManager.clear()
	GameState.new_game()

	PanelManager.register_puzzle("solution_test", 3)
	PanelManager.add_solution("solution_test", [2, 1, 0])  # Reversed is solution

	# Add configuration with unlock
	PanelManager.add_configuration("solution_test", [2, 1, 0], {"down": "earth"}, ["GRAVITY_FIXED"])

	PanelManager.set_active_puzzle("solution_test")

	# Not solved initially
	assert_false(PanelManager.is_puzzle_solved("solution_test"), "Not solved initially")

	# Make moves to reach solution
	PanelManager.swap_panels(0, 2)  # [2, 1, 0]

	# Now solved
	assert_true(PanelManager.is_puzzle_solved("solution_test"), "Puzzle solved after correct arrangement")

	# Flag should be set
	assert_true(GameState.has_flag("GRAVITY_FIXED"), "Unlock flag set on solve")


# ----------------------------------------------------------------------------
# TEST: Exits Configuration
# ----------------------------------------------------------------------------

func test_exits_configuration() -> void:
	print("\n--- Exits Configuration ---")
	PanelManager.clear()

	PanelManager.register_puzzle("exits_test", 3)

	# Default order has no exits
	PanelManager.add_configuration("exits_test", [0, 1, 2], {}, [])

	# Rearranged order unlocks "down" exit
	PanelManager.add_configuration("exits_test", [1, 0, 2], {"down": "room_below"}, [])

	# Different arrangement unlocks "right" exit
	PanelManager.add_configuration("exits_test", [2, 1, 0], {"right": "room_right"}, [])

	PanelManager.set_active_puzzle("exits_test")

	# Initial: no exits
	assert_false(PanelManager.has_exit("exits_test", "down"), "No down exit initially")

	# Swap to get [1, 0, 2]
	PanelManager.swap_panels(0, 1)
	assert_true(PanelManager.has_exit("exits_test", "down"), "Down exit available after rearrange")
	assert_eq(PanelManager.get_exit_destination("exits_test", "down"), "room_below", "Correct destination")

	# Swap more to get [2, 0, 1] - no configured exits
	PanelManager.swap_panels(0, 2)  # [2, 0, 1]
	assert_false(PanelManager.has_exit("exits_test", "down"), "Down exit gone with different arrangement")

	# Set to [2, 1, 0] for right exit
	var order: Array[int] = [2, 1, 0]
	PanelManager.set_order("exits_test", order)
	assert_true(PanelManager.has_exit("exits_test", "right"), "Right exit available")


# ----------------------------------------------------------------------------
# TEST: Narrator Reactions
# ----------------------------------------------------------------------------

func test_narrator_reactions() -> void:
	print("\n--- Narrator Reactions ---")
	PanelManager.clear()

	PanelManager.register_puzzle("narrator_test", 2)
	PanelManager.add_solution("narrator_test", [1, 0])

	PanelManager.add_narrator_messages("narrator_test", {
		"protest": "Hey! That's not how the story goes!",
		"confusion": "Wait, where did the... oh.",
		"impressed": "Huh. Clever."
	})

	PanelManager.set_active_puzzle("narrator_test")

	# Track narrator reaction using array (reference type)
	var reaction_data := [["", ""]]

	var callback = func(rtype: String, msg: String):
		reaction_data[0] = [rtype, msg]

	PanelManager.narrator_reaction.connect(callback)

	# Swap panels - this is actually the solution [1, 0]
	PanelManager.swap_panels(0, 1)

	# Should get impressed reaction (puzzle solved)
	assert_eq(reaction_data[0][0], "impressed", "Narrator impressed on solution")
	assert_eq(reaction_data[0][1], "Huh. Clever.", "Correct impressed message")

	# Disconnect
	PanelManager.narrator_reaction.disconnect(callback)
