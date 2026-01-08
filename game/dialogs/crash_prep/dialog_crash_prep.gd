extends PopochiuDialog

## Crash Prep dialog - Final puzzle: How to prepare for crash
## Three solutions: full prep (Brains), human seatbelt (Brawn), calm deer (Bizarre)


func _on_start() -> void:
	await E.queue([
		"*The plane shakes violently*",
		"*You have seconds to prepare*",
	])

	if GameState.has_party_member("Pig"):
		await C.player.say("WHAT DO WE DO?!")

	await C.Tank.say("I... I need to protect everyone!")

	await E.queue([
		"*Life vests nearby*",
		"*Cargo straps on the wall*",
		"*Mr. Snuggles tapping frantically*",
	])


func _option_selected(opt: PopochiuDialogOption) -> void:
	var room: Node = R.PlaneHold

	match opt.id:
		"full_prep":
			# Brains solution: Maximum preparation
			stop()
			await room.execute_brains_full_prep()
		"human_shield":
			# Brawn solution: Tank protects everyone physically
			stop()
			await room.execute_brawn_human_shield()
		"calm_deer":
			# Bizarre solution: Focus on calming Mr. Snuggles
			stop()
			await room.execute_bizarre_calm_deer()
		"panic":
			# Fail-forward: Do nothing
			stop()
			await room.execute_fail_forward_panic()
		_:
			stop()
