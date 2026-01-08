extends Node
## Word Manager - handles the "Repair the story while playing it" signature hook.
## Words can drop from sentences, become inventory items, and be pasted back.

# Preload the DroppableWord resource
const DroppableWordClass = preload("res://game/resources/droppable_word.gd")

# ============================================================================
# SIGNALS
# ============================================================================

signal word_dropped(word: Resource)  # DroppableWord
signal word_pasted(word: Resource, target_id: String)  # DroppableWord
signal sentence_changed(sentence_id: String, new_text: String)

# ============================================================================
# CONSTANTS
# ============================================================================

## Special marker for where a word was removed from a sentence
const GAP_MARKER = "[___]"

# ============================================================================
# STATE
# ============================================================================

## All registered sentences that can have words drop
## Format: { "sentence_id": { "original": "full text", "words": [DroppableWord], "current": "text with gaps" } }
var sentences: Dictionary = {}

## Words currently in inventory (dropped from sentences)
## Format: { "word_id": Resource }
var dropped_words: Dictionary = {}

## Paste targets - places words can be inserted
## Format: { "target_id": { "accepts": ["word_type"], "filled_with": null or DroppableWord } }
var paste_targets: Dictionary = {}

# ============================================================================
# SENTENCE MANAGEMENT
# ============================================================================

## Register a sentence that can have words drop from it
func register_sentence(sentence_id: String, text: String, droppable_indices: Array[int] = []) -> void:
	var words: Array = []

	# Parse words at droppable indices
	var word_list = text.split(" ")
	for idx in droppable_indices:
		if idx >= 0 and idx < word_list.size():
			var word = DroppableWordClass.new(word_list[idx], sentence_id, idx)
			words.append(word)

	sentences[sentence_id] = {
		"original": text,
		"words": words,
		"current": text,
		"dropped_indices": []
	}


## Get the current display text for a sentence (with gaps)
func get_sentence_text(sentence_id: String) -> String:
	if sentence_id not in sentences:
		return ""
	return sentences[sentence_id].current


## Get the original text of a sentence
func get_original_text(sentence_id: String) -> String:
	if sentence_id not in sentences:
		return ""
	return sentences[sentence_id].original


# ============================================================================
# WORD DROPPING
# ============================================================================

## Drop a word from a sentence (word becomes inventory item)
func drop_word(sentence_id: String, word_index: int) -> Resource:
	if sentence_id not in sentences:
		push_error("WordManager: Unknown sentence '%s'" % sentence_id)
		return null

	var sentence_data = sentences[sentence_id]

	# Find the word to drop
	var word_to_drop: Resource = null
	for w in sentence_data.words:
		if w.position_in_sentence == word_index:
			word_to_drop = w
			break

	if not word_to_drop:
		push_error("WordManager: No droppable word at index %d in '%s'" % [word_index, sentence_id])
		return null

	# Check if already dropped
	if word_index in sentence_data.dropped_indices:
		return null

	# Mark as dropped
	sentence_data.dropped_indices.append(word_index)

	# Update sentence display
	_update_sentence_display(sentence_id)

	# Add to dropped words
	var word_id = "word_%s_%s_%d" % [sentence_id, word_to_drop.word.to_lower(), word_index]
	dropped_words[word_id] = word_to_drop

	# Emit signal
	word_dropped.emit(word_to_drop)

	print("[WordManager] Dropped word '%s' from sentence '%s'" % [word_to_drop.word, sentence_id])

	return word_to_drop


## Drop a word by its actual text content
func drop_word_by_text(sentence_id: String, word_text: String) -> Resource:
	if sentence_id not in sentences:
		return null

	var sentence_data = sentences[sentence_id]
	for w in sentence_data.words:
		if w.word.to_lower() == word_text.to_lower():
			return drop_word(sentence_id, w.position_in_sentence)

	return null


## Update the display text with gaps
func _update_sentence_display(sentence_id: String) -> void:
	var sentence_data = sentences[sentence_id]
	var words = sentence_data.original.split(" ")

	for idx in sentence_data.dropped_indices:
		if idx < words.size():
			words[idx] = GAP_MARKER

	sentence_data.current = " ".join(words)
	sentence_changed.emit(sentence_id, sentence_data.current)


# ============================================================================
# PASTE TARGETS
# ============================================================================

## Register a place where words can be pasted
func register_paste_target(target_id: String, accepted_types: Array[String] = [], effect: String = "") -> void:
	paste_targets[target_id] = {
		"accepts": accepted_types,
		"filled_with": null,
		"effect": effect
	}


## Check if a word can be pasted at a target
func can_paste_at(word: Resource, target_id: String) -> bool:
	if target_id not in paste_targets:
		return false

	var target = paste_targets[target_id]

	# Already filled?
	if target.filled_with != null:
		return false

	# Check word type
	if target.accepts.size() > 0 and word.word_type not in target.accepts:
		return false

	# Check specific valid targets
	if word.valid_targets.size() > 0 and target_id not in word.valid_targets:
		return false

	return true


## Paste a word at a target
func paste_word(word: Resource, target_id: String) -> bool:
	if not can_paste_at(word, target_id):
		return false

	var target = paste_targets[target_id]

	# Fill target with word
	target.filled_with = word

	# Remove from dropped words
	var word_id_to_remove = ""
	for wid in dropped_words:
		if dropped_words[wid] == word:
			word_id_to_remove = wid
			break

	if word_id_to_remove:
		dropped_words.erase(word_id_to_remove)

	# Apply effect
	if target.effect:
		_apply_paste_effect(target.effect, word)

	word_pasted.emit(word, target_id)

	print("[WordManager] Pasted word '%s' at target '%s'" % [word.word, target_id])

	return true


## Apply the effect of pasting a word
func _apply_paste_effect(effect: String, word: Resource) -> void:
	# Parse effect string
	# Format: "flag:FLAG_NAME" or "action:ACTION_NAME" or "unlock:DOOR_ID"
	var parts = effect.split(":")
	if parts.size() < 2:
		return

	var effect_type = parts[0]
	var effect_value = parts[1]

	match effect_type:
		"flag":
			GameState.set_flag(effect_value, true)
		"unlock":
			GameState.set_flag("unlocked_" + effect_value, true)
		"meter":
			# Format: "meter:heat:10" or "meter:ignorance:-5"
			if parts.size() >= 3:
				var amount = int(parts[2])
				match effect_value:
					"heat": GameState.modify_heat(amount)
					"ignorance": GameState.modify_ignorance(amount)
					"morale": GameState.modify_morale(amount)
		_:
			print("[WordManager] Unknown effect type: %s" % effect_type)


# ============================================================================
# RESTORE WORDS
# ============================================================================

## Restore a word back to its original sentence
func restore_word(word: Resource) -> bool:
	var sentence_id = word.source_sentence_id
	if sentence_id not in sentences:
		return false

	var sentence_data = sentences[sentence_id]
	var idx = word.position_in_sentence

	if idx not in sentence_data.dropped_indices:
		return false  # Word wasn't dropped

	# Remove from dropped indices
	sentence_data.dropped_indices.erase(idx)

	# Update display
	_update_sentence_display(sentence_id)

	# Remove from dropped_words
	var word_id_to_remove = ""
	for wid in dropped_words:
		if dropped_words[wid] == word:
			word_id_to_remove = wid
			break

	if word_id_to_remove:
		dropped_words.erase(word_id_to_remove)

	print("[WordManager] Restored word '%s' to sentence '%s'" % [word.word, sentence_id])

	return true


# ============================================================================
# UTILITY
# ============================================================================

## Get all currently dropped words
func get_dropped_words() -> Array:
	return dropped_words.values()


## Get count of dropped words
func get_dropped_word_count() -> int:
	return dropped_words.size()


## Check if a specific word is in inventory
func has_word(word_text: String) -> bool:
	for word in dropped_words.values():
		if word.word.to_lower() == word_text.to_lower():
			return true
	return false


## Get a dropped word by its text
func get_word(word_text: String) -> Resource:
	for word in dropped_words.values():
		if word.word.to_lower() == word_text.to_lower():
			return word
	return null


## Check if a sentence is fully restored
func is_sentence_complete(sentence_id: String) -> bool:
	if sentence_id not in sentences:
		return true
	return sentences[sentence_id].dropped_indices.size() == 0


# ============================================================================
# SAVE/LOAD
# ============================================================================

func save_state() -> Dictionary:
	var saved_sentences := {}
	for sid in sentences:
		saved_sentences[sid] = {
			"dropped_indices": sentences[sid].dropped_indices.duplicate()
		}

	var saved_targets := {}
	for tid in paste_targets:
		saved_targets[tid] = {
			"filled_with_word": paste_targets[tid].filled_with.word if paste_targets[tid].filled_with else null
		}

	return {
		"sentences": saved_sentences,
		"paste_targets": saved_targets
	}


func load_state(data: Dictionary) -> void:
	# Re-drop words based on saved state
	var saved_sentences = data.get("sentences", {})
	for sid in saved_sentences:
		if sid in sentences:
			for idx in saved_sentences[sid].get("dropped_indices", []):
				drop_word(sid, idx)

	# Note: Full restoration of paste targets requires re-registration
	# This is simplified - in a real game, targets would be re-registered by room scripts


## Clear all state
func clear() -> void:
	sentences.clear()
	dropped_words.clear()
	paste_targets.clear()
