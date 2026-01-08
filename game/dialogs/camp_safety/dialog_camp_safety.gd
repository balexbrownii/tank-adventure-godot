@tool
extends PopochiuDialog
## Dialog for setting up camp safety.
## Three approaches: Brains (noise trap), Brawn (stand guard), Bizarre (deer listens)


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("How should we secure the camp?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"noise_trap":
			# BRAINS solution - Pig sets up noise trap
			await C.player.say("Pig, can you make a trap?")
			stop()
			await R.OakTreeCamp.execute_brains_solution()

		"stand_guard":
			# BRAWN solution - Tank stands guard
			await C.player.say("I'll protect us!")
			stop()
			await R.OakTreeCamp.execute_brawn_solution()

		"deer_listens":
			# BIZARRE solution - Mr. Snuggles listens for danger
			await C.player.say("What about Mr. Snuggles?")
			stop()
			await R.OakTreeCamp.execute_bizarre_solution()

		"do_nothing":
			# Fail-forward path
			await C.player.say("We'll be fine... right?")
			stop()
			await R.OakTreeCamp.execute_fail_forward()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
