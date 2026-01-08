@tool
extends PopochiuHotspot
## Hotspot: Trail Fork (PATH OF DESTINY / Trail Fork)
## Exit from the picnic area - blocked until food is dealt with

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	if not room.state.food_eaten and not room.state.saved_as_bait:
		await E.queue([
			"Tank: I should eat first!",
			"Tank: A warrior never marches on an empty stomach!",
		])
		return

	if room.state.hungry_debuff:
		await E.queue([
			"Tank: *stomach growls*",
			"Tank: I'm hungry but MOTIVATED!",
			"Tank: Onward to GLORY!",
		])
	else:
		await E.queue([
			"Tank: *pats stomach*",
			"Tank: That was a good breakfast!",
			"Tank: Now... which way to ADVENTURE?",
		])

	# Transition to next room
	E.goto_room("RoadMonsters")


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["trail_fork"])
	await C.Tank.say(text)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.Tank.say("I should just pick a path and GO!")


#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await _on_look()


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await _on_interact()


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Paths! Which way leads to adventure?")
	await C.player.say("...all of them? Excellent!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a trail fork!")
	await C.player.say("I can only WALK them!")


#endregion
