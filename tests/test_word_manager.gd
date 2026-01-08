extends Node
## Unit tests for WordManager autoload (signature hook)

var tests_passed := 0
var tests_failed := 0


func _ready() -> void:
	print("\n=== WORD MANAGER UNIT TESTS ===\n")

	# Reset state
	WordManager.clear()
	GameState.new_game()

	# Run tests
	test_sentence_registration()
	test_word_dropping()
	test_sentence_display()
	test_paste_targets()
	test_word_restore()
	test_paste_effects()

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
# TEST: Sentence Registration
# ----------------------------------------------------------------------------

func test_sentence_registration() -> void:
	print("\n--- Sentence Registration ---")
	WordManager.clear()

	# Register a sentence with droppable words at indices 2 and 4
	WordManager.register_sentence("test_sentence", "The quick brown fox jumps", [2, 4])

	assert_eq(WordManager.get_original_text("test_sentence"), "The quick brown fox jumps", "Original text stored")
	assert_eq(WordManager.get_sentence_text("test_sentence"), "The quick brown fox jumps", "Current text starts as original")

	# Unknown sentence returns empty
	assert_eq(WordManager.get_sentence_text("unknown"), "", "Unknown sentence returns empty")


# ----------------------------------------------------------------------------
# TEST: Word Dropping
# ----------------------------------------------------------------------------

func test_word_dropping() -> void:
	print("\n--- Word Dropping ---")
	WordManager.clear()

	WordManager.register_sentence("drop_test", "Tank ate the poison mushroom", [2, 4])

	# Drop word at index 2 ("the")
	var word = WordManager.drop_word("drop_test", 2)
	assert_true(word != null, "Word dropped successfully")
	assert_eq(word.word, "the", "Dropped correct word")

	# Word is now in inventory
	assert_true(WordManager.has_word("the"), "Word is in inventory")
	assert_eq(WordManager.get_dropped_word_count(), 1, "Dropped word count is 1")

	# Can't drop same word twice
	var word2 = WordManager.drop_word("drop_test", 2)
	assert_true(word2 == null, "Can't drop same word twice")

	# Drop by text
	var word3 = WordManager.drop_word_by_text("drop_test", "mushroom")
	assert_true(word3 != null, "Drop by text works")
	assert_eq(WordManager.get_dropped_word_count(), 2, "Now have 2 dropped words")


# ----------------------------------------------------------------------------
# TEST: Sentence Display
# ----------------------------------------------------------------------------

func test_sentence_display() -> void:
	print("\n--- Sentence Display ---")
	WordManager.clear()

	WordManager.register_sentence("display_test", "The WOLF ate my bacon", [1, 4])

	# Drop first word
	WordManager.drop_word("display_test", 1)
	var text = WordManager.get_sentence_text("display_test")
	assert_eq(text, "The [___] ate my bacon", "Gap appears where word was dropped")

	# Drop second word
	WordManager.drop_word("display_test", 4)
	text = WordManager.get_sentence_text("display_test")
	assert_eq(text, "The [___] ate my [___]", "Two gaps appear")

	# Sentence not complete
	assert_false(WordManager.is_sentence_complete("display_test"), "Sentence not complete")


# ----------------------------------------------------------------------------
# TEST: Paste Targets
# ----------------------------------------------------------------------------

func test_paste_targets() -> void:
	print("\n--- Paste Targets ---")
	WordManager.clear()

	# Register sentence and drop a word
	WordManager.register_sentence("paste_test", "Open the door", [1])
	var word = WordManager.drop_word("paste_test", 1)

	# Register paste target
	WordManager.register_paste_target("magic_door", ["NOUN"], "unlock:magic_door")

	# Can paste?
	assert_true(WordManager.can_paste_at(word, "magic_door"), "Can paste NOUN at target")

	# Actually paste
	var result = WordManager.paste_word(word, "magic_door")
	assert_true(result, "Paste succeeded")

	# Word no longer in inventory
	assert_false(WordManager.has_word("the"), "Word removed from inventory after paste")

	# Can't paste again (target filled)
	WordManager.register_sentence("paste_test2", "Find the key", [1])
	var word2 = WordManager.drop_word("paste_test2", 1)
	assert_false(WordManager.can_paste_at(word2, "magic_door"), "Can't paste at filled target")


# ----------------------------------------------------------------------------
# TEST: Word Restore
# ----------------------------------------------------------------------------

func test_word_restore() -> void:
	print("\n--- Word Restore ---")
	WordManager.clear()

	WordManager.register_sentence("restore_test", "The gravity was heavy", [1])
	var word = WordManager.drop_word("restore_test", 1)

	# Sentence has gap
	var text1 = WordManager.get_sentence_text("restore_test")
	assert_eq(text1, "The [___] was heavy", "Gap exists before restore")

	# Restore the word
	var restored = WordManager.restore_word(word)
	assert_true(restored, "Restore succeeded")

	# Sentence is whole again
	var text2 = WordManager.get_sentence_text("restore_test")
	assert_eq(text2, "The gravity was heavy", "Sentence restored")

	# Word no longer in inventory
	assert_false(WordManager.has_word("gravity"), "Word removed from inventory")

	# Sentence is complete
	assert_true(WordManager.is_sentence_complete("restore_test"), "Sentence complete after restore")


# ----------------------------------------------------------------------------
# TEST: Paste Effects
# ----------------------------------------------------------------------------

func test_paste_effects() -> void:
	print("\n--- Paste Effects ---")
	WordManager.clear()
	GameState.new_game()

	# Test flag effect
	WordManager.register_paste_target("flag_target", [], "flag:DOOR_OPENED")
	var word1 = load("res://game/resources/droppable_word.gd").new("key", "test", 0)
	WordManager.dropped_words["test_key"] = word1

	WordManager.paste_word(word1, "flag_target")
	assert_true(GameState.has_flag("DOOR_OPENED"), "Flag set by paste effect")

	# Test meter effect
	WordManager.clear()
	GameState.new_game()
	var initial_heat = GameState.heat

	WordManager.register_paste_target("heat_target", [], "meter:heat:10")
	var word2 = load("res://game/resources/droppable_word.gd").new("fire", "test", 0)
	WordManager.dropped_words["test_fire"] = word2

	WordManager.paste_word(word2, "heat_target")
	assert_eq(GameState.heat, initial_heat + 10, "Meter modified by paste effect")
