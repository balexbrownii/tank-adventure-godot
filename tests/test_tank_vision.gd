extends Node
## Unit tests for TankVision autoload

var tests_passed := 0
var tests_failed := 0


func _ready() -> void:
	print("\n=== TANK VISION UNIT TESTS ===\n")

	# Reset state
	TankVision.current_mode = TankVision.VisionMode.TANK
	TankVision.told_topics.clear()

	# Run tests
	test_default_mode()
	test_toggle_vision()
	test_mode_checks()
	test_label_retrieval()
	test_tell_tank()
	test_dumb_options()

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
# TEST: Default Mode
# ----------------------------------------------------------------------------

func test_default_mode() -> void:
	print("\n--- Default Mode ---")
	TankVision.current_mode = TankVision.VisionMode.TANK

	assert_eq(TankVision.current_mode, TankVision.VisionMode.TANK, "Starts in Tank Vision")
	assert_true(TankVision.is_tank_vision(), "is_tank_vision() returns true")
	assert_false(TankVision.is_reality_vision(), "is_reality_vision() returns false")


# ----------------------------------------------------------------------------
# TEST: Toggle Vision
# ----------------------------------------------------------------------------

func test_toggle_vision() -> void:
	print("\n--- Toggle Vision ---")
	TankVision.current_mode = TankVision.VisionMode.TANK

	TankVision.toggle_vision()
	assert_eq(TankVision.current_mode, TankVision.VisionMode.REALITY, "Toggle switches to Reality")
	assert_true(TankVision.is_reality_vision(), "is_reality_vision() true after toggle")

	TankVision.toggle_vision()
	assert_eq(TankVision.current_mode, TankVision.VisionMode.TANK, "Toggle switches back to Tank")
	assert_true(TankVision.is_tank_vision(), "is_tank_vision() true after second toggle")


# ----------------------------------------------------------------------------
# TEST: Mode Checks
# ----------------------------------------------------------------------------

func test_mode_checks() -> void:
	print("\n--- Mode Checks ---")

	TankVision.set_vision_mode(TankVision.VisionMode.TANK)
	assert_true(TankVision.is_tank_vision(), "set_vision_mode(TANK) works")

	TankVision.set_vision_mode(TankVision.VisionMode.REALITY)
	assert_true(TankVision.is_reality_vision(), "set_vision_mode(REALITY) works")


# ----------------------------------------------------------------------------
# TEST: Label Retrieval
# ----------------------------------------------------------------------------

func test_label_retrieval() -> void:
	print("\n--- Label Retrieval ---")

	var hotspot_data := {
		"tank_hover": "MYSTERY BOX",
		"tank_inspect": "It's a box of mystery!",
		"reality_hover": "First Aid Kit",
		"reality_inspect": "A standard first aid kit."
	}

	# Tank Vision
	TankVision.set_vision_mode(TankVision.VisionMode.TANK)
	assert_eq(TankVision.get_hover_label(hotspot_data), "MYSTERY BOX", "Tank hover label correct")
	assert_eq(TankVision.get_inspect_text(hotspot_data), "It's a box of mystery!", "Tank inspect text correct")

	# Reality Vision
	TankVision.set_vision_mode(TankVision.VisionMode.REALITY)
	assert_eq(TankVision.get_hover_label(hotspot_data), "First Aid Kit", "Reality hover label correct")
	assert_eq(TankVision.get_inspect_text(hotspot_data), "A standard first aid kit.", "Reality inspect text correct")

	# Missing data fallbacks
	var empty_data := {}
	assert_eq(TankVision.get_hover_label(empty_data), "???", "Missing hover returns fallback")
	assert_eq(TankVision.get_inspect_text(empty_data), "It's a thing.", "Missing inspect returns fallback")


# ----------------------------------------------------------------------------
# TEST: Tell Tank
# ----------------------------------------------------------------------------

func test_tell_tank() -> void:
	print("\n--- Tell Tank ---")
	TankVision.told_topics.clear()
	GameState.new_game()

	# Before telling
	assert_false(TankVision.was_tank_told("cars_are_not_monsters"), "Topic unknown before telling")

	# Remember initial ignorance
	var initial_ignorance = GameState.ignorance

	# Tell Tank
	TankVision.tell_tank("cars_are_not_monsters")

	assert_true(TankVision.was_tank_told("cars_are_not_monsters"), "Topic known after telling")
	assert_true(GameState.ignorance < initial_ignorance, "Ignorance decreased after telling")

	# Can't tell twice
	var current_ignorance = GameState.ignorance
	TankVision.tell_tank("cars_are_not_monsters")
	assert_eq(GameState.ignorance, current_ignorance, "Ignorance doesn't decrease on duplicate tell")


# ----------------------------------------------------------------------------
# TEST: Dumb Options
# ----------------------------------------------------------------------------

func test_dumb_options() -> void:
	print("\n--- Dumb Options ---")
	TankVision.told_topics.clear()

	# Dumb option available before telling Tank
	assert_true(TankVision.is_dumb_option_available("cars_are_monsters"), "Dumb option available before telling")

	# Tell Tank
	TankVision.tell_tank("cars_are_monsters")

	# Dumb option no longer available
	assert_false(TankVision.is_dumb_option_available("cars_are_monsters"), "Dumb option unavailable after telling")

	# Test array filtering
	var options: Array[String] = ["cars_are_monsters", "soldiers_are_friends", "poison_is_food"]
	TankVision.tell_tank("poison_is_food")

	var available = TankVision.get_available_dumb_options(options)
	assert_eq(available.size(), 1, "Only untold options remain")
	assert_true("soldiers_are_friends" in available, "Untold option is available")
