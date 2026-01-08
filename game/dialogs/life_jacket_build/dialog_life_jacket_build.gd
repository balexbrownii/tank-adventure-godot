@tool
extends PopochiuDialog
## Dialog for life jacket building puzzle.
## Three approaches: Brains (Pig guides), Brawn (Tank overbuilds), Bizarre (Deer tests)


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("Time to make Mr. Snuggles a life jacket!")
	await E.queue([
		"*The materials are gathered: driftwood, cloth, vines*",
	])


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"pig_guides":
			# BRAINS solution - Pig's efficient design
			await C.player.say("Pig, you're the smart one. Tell me what to do!")
			stop()
			await R.BrazilEdgeBeach.execute_brains_solution()

		"tank_overbuilds":
			# BRAWN solution - More is more!
			await C.player.say("I know EXACTLY how to do this!")
			await C.player.say("MORE FLOATY STUFF = MORE SAFE!")
			stop()
			await R.BrazilEdgeBeach.execute_brawn_solution()

		"deer_tests":
			# BIZARRE solution - Mr. Snuggles decides
			await C.player.say("MR. SNUGGLES! You're wearing it!")
			await C.player.say("YOU should decide how it fits!")
			stop()
			await R.BrazilEdgeBeach.execute_bizarre_solution()

		"just_try":
			# Fail-forward - Wing it
			await C.player.say("How hard can it be?")
			stop()
			await R.BrazilEdgeBeach.execute_fail_forward()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
