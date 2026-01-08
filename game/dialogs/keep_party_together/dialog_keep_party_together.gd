extends PopochiuDialog

## Keep Party Together dialog - Puzzle B: Don't lose the deer
## Three solutions: rope link (Brains), follow tapping sound (Bizarre), stop belt (Brawn)


func _on_start() -> void:
	await E.queue([
		"The conveyor belt starts moving.",
		"Tank's suitcase and Mr. Snuggles' suitcase are drifting apart!",
	])

	await C.Tank.say("No! We can't lose Mr. Snuggles!")

	if GameState.has_party_member("Pig"):
		await C.player.say("Quick! We need to keep the suitcases together!")

	await E.queue([
		"*tap tap tap* - Mr. Snuggles taps from inside his suitcase.",
	])


func _option_selected(opt: PopochiuDialogOption) -> void:
	var room: Node = R.LuggageRoom

	match opt.id:
		"use_rope":
			# Brains solution: Link suitcases with rope
			stop()
			await room.execute_brains_rope_link()
			await _complete_room()
		"follow_sound":
			# Bizarre solution: Follow deer's tapping
			stop()
			await room.execute_bizarre_sound_follow()
			await _complete_room()
		"stop_belt":
			# Brawn solution: Shoulder-barge the belt
			stop()
			await room.execute_brawn_belt_stop()
			await _complete_room()
		"do_nothing":
			# Fail-forward: Lose deer temporarily
			stop()
			await room.execute_link_fail_forward()
			await _complete_room()
		_:
			stop()


func _complete_room() -> void:
	var room: Node = R.LuggageRoom
	await room.complete_room()
