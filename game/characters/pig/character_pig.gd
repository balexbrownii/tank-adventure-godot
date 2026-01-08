@tool
extends PopochiuCharacter
## Pig - The western-talking planning pig who rides Mr. Snuggles
## Speaks with a western accent ("Whudyue tink your doin'!")
## Wears tight workout pants. The smart one who plans the route.

const Data := preload('character_pig_state.gd')

var state: Data = load("res://game/characters/pig/character_pig.tres")


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
	await C.player.say("That's Pig! He's real smart and talks funny.")
	await C.player.say("He wears tight workout pants.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await say("Whudyue want now, Tank?")
	await C.player.say("Just saying hi!")
	await say("Well, howdy then. Now git back to work!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I don't think Pig would like that.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I could carry Pig...")
	await say("Don't you dare, Tank!")
	await C.player.say("Never mind!")


#endregion
