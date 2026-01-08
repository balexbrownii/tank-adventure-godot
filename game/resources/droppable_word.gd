@tool
class_name DroppableWord
extends Resource
## A word that can drop from a sentence and become an inventory item.
## Part of the "Repair the story while playing it" signature hook.

## The actual word text
@export var word: String = ""

## Display name in inventory (may be stylized)
@export var display_name: String = ""

## Description when examined in inventory
@export_multiline var description: String = ""

## The source sentence ID this word came from
@export var source_sentence_id: String = ""

## Position in the source sentence (word index)
@export var position_in_sentence: int = 0

## Category for combining/matching puzzles
@export_enum("NOUN", "VERB", "ADJECTIVE", "PROPER_NOUN", "NUMBER") var word_type: String = "NOUN"

## Where this word can be pasted (empty = anywhere accepting words)
@export var valid_targets: Array[String] = []

## Effect when pasted (flag to set or action to trigger)
@export var paste_effect: String = ""

## Icon for inventory display (optional)
@export var icon: Texture2D


func _init(p_word: String = "", p_source: String = "", p_position: int = 0) -> void:
	word = p_word
	display_name = p_word.to_upper() if p_word else ""
	source_sentence_id = p_source
	position_in_sentence = p_position


## Create inventory item data compatible with Popochiu
func to_inventory_data() -> Dictionary:
	return {
		"id": "word_%s" % word.to_lower().replace(" ", "_"),
		"name": display_name if display_name else word.to_upper(),
		"description": description if description else '"%s" - a word you collected.' % word,
		"word_resource": self
	}
