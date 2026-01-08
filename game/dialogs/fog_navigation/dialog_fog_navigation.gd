@tool
extends PopochiuDialog
## Dialog for fog navigation - the main Caribbean Raft puzzle.
## Three ways to find Puerto Rico: sound, stars, or echo.


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("We need to find land!")
	await E.queue([
		"Pig: The fog's too thick to see. We need another way.",
	])


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"follow_sounds":
			# BRAINS solution 1 - Follow gull sounds
			await C.player.say("Wait... I hear birds!")
			await E.queue([
				"Pig: Good ears! Birds mean land's nearby.",
			])
			stop()
			await R.CaribbeanRaft.execute_brains_sound_solution()

		"read_stars":
			# BRAINS solution 2 - Star navigation
			await C.player.say("Pig! Use your fancy SKY READING!")
			await E.queue([
				"Pig: ...you mean navigation?",
				"Pig: Alright, lemme check the stars.",
			])
			stop()
			await R.CaribbeanRaft.execute_brains_star_solution()

		"yell_echo":
			# BIZARRE solution - LAND AHOY echo trick
			await C.player.say("I have the BEST idea!")
			await E.queue([
				"Pig: Why do I have a bad feelin' about this...",
			])
			stop()
			await R.CaribbeanRaft.execute_bizarre_solution()

		"just_paddle":
			# FAIL-FORWARD solution - Random paddling
			await C.player.say("Let's just GO!")
			await E.queue([
				"Pig: Tank, we don't know which-",
			])
			await C.player.say("ADVENTURE WAITS FOR NO ONE!")
			stop()
			await R.CaribbeanRaft.execute_fail_forward()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
