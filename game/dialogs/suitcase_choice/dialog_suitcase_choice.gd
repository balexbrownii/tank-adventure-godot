extends PopochiuDialog

## Suitcase Choice dialog - Puzzle A: Find the Texas suitcase
## Three solutions: rotate tag text (Brains), craft new tag (Brains), rip and force (Brawn)


func _on_start() -> void:
	await E.queue([
		"Tank examines the pile of suitcases.",
		"All the destination tags have scrambled, jumbled text.",
	])

	await C.Tank.say("Which one goes to TEXAS?")

	if GameState.has_party_member("Pig"):
		await C.player.say("The tags are messed up. We need to figure out the letters.")

	await E.queue([
		"The scrambled tags read things like 'XASTE', 'SAETX', 'TXESA'...",
	])


func _option_selected(opt: PopochiuDialogOption) -> void:
	var room: Node = R.LuggageRoom

	match opt.id:
		"rotate_text":
			# Brains solution 1: Device 6 style text manipulation
			stop()
			await room.execute_brains_tag_puzzle()
		"craft_tag":
			# Brains solution 2: Pig crafts a new tag
			stop()
			await room.execute_brains_craft_solution()
		"force_tags":
			# Brawn solution: Rip and reattach
			stop()
			await room.execute_brawn_tag_solution()
		"random_guess":
			# Fail-forward: Wrong suitcase
			stop()
			await room.execute_tag_fail_forward()
			# Dialog may restart after fail-forward
		_:
			stop()
