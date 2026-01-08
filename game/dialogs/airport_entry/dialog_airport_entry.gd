@tool
extends PopochiuDialog
## Dialog for airport entrance puzzle.
## Three solutions: Disguise (Brains), Distraction (Brawn), Support Deer (Bizarre).


#region Virtual ####################################################################################
func _on_start() -> void:
	await E.queue([
		"Pig: How we gettin' in there?",
		"Tank: I have SEVERAL ideas!",
	])


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"disguise":
			# BRAINS solution - Wear vest and clipboard
			await C.player.say("We'll DISGUISE ourselves!")
			await E.queue([
				"Pig: Smart. Grab that vest and clipboard.",
			])
			stop()
			await R.FloridaAirport.execute_brains_solution()

		"distraction":
			# BRAWN solution - Tank causes chaos
			await C.player.say("I'll CREATE A DIVERSION!")
			await E.queue([
				"Pig: Tank, please don't-",
			])
			stop()
			await R.FloridaAirport.execute_brawn_solution()

		"support_deer":
			# BIZARRE solution - Emotional Support Deer
			await C.player.say("Mr. Snuggles is my EMOTIONAL SUPPORT!")
			await E.queue([
				"Mr. Snuggles: *looks official*",
			])
			stop()
			await R.FloridaAirport.execute_bizarre_solution()

		"just_walk":
			# FAIL-FORWARD - Just try to walk in
			await C.player.say("Let's just WALK IN!")
			await E.queue([
				"Pig: That's gonna work great.",
			])
			stop()
			await R.FloridaAirport.execute_fail_forward()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
