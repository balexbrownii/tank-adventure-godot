@tool
extends PopochiuCharacter
## Mr. Snuggles - A calm deer that Pig rides
## Gets a life jacket for sea crossing. Always zen and peaceful.
## The calm straight-man to the chaos.

const Data := preload('character_mr_snuggles_state.gd')

var state: Data = load("res://game/characters/mr_snuggles/character_mr_snuggles.tres")


#region Virtual ####################################################################################
func _on_room_set() -> void:
	pass


func _on_click() -> void:
	E.command_fallback()


func _on_double_click() -> void:
	E.command_fallback()


func _on_right_click() -> void:
	E.command_fallback()


func _on_middle_click() -> void:
	E.command_fallback()


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	E.command_fallback()


func _play_idle() -> void:
	super()


func _play_walk(target_pos: Vector2) -> void:
	super(target_pos)


func _play_talk() -> void:
	super()


func _play_grab() -> void:
	super()


func _on_movement_started() -> void:
	pass


func _on_movement_ended() -> void:
	pass


#endregion

#region Public #####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("That's Mr. Snuggles! He's a deer.")
	await C.player.say("He's very calm. Nothing bothers him.")
	await C.player.say("I wish I could be that relaxed!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hey Mr. Snuggles! How are you?")
	await say("...")
	await C.player.say("He blinked! That means he's happy!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Mr. Snuggles is for riding, not using!")
	await say("...")
	await C.player.say("See? He agrees.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I could pick up Mr. Snuggles...")
	await C.player.say("But that seems rude. He has dignity.")
	await say("...")
	await C.player.say("He appreciates my respect!")


#endregion
