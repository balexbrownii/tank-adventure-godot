@tool
extends PopochiuDialog
## Dialog for "borrowing" a boat in Puerto Rico.
## Three solutions: Permission Slip (Brains), Lift (Brawn), Teamwork (Bizarre).


#region Virtual ####################################################################################
func _on_start() -> void:
	await E.queue([
		"Pig: Okay, we need to get that boat.",
		"Pig: Any ideas?",
		"Tank: MANY IDEAS!",
	])


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"permission":
			# BRAINS solution - Get official permission
			await C.player.say("Let's do this PROPERLY!")
			await E.queue([
				"Pig: ...that's surprisingly responsible of ya.",
			])
			stop()
			await R.PuertoRico.execute_boat_brains_solution()

		"lift":
			# BRAWN solution - Tank lifts boat
			await C.player.say("I'LL JUST TAKE IT!")
			await E.queue([
				"Pig: Tank, no-",
			])
			stop()
			await R.PuertoRico.execute_boat_brawn_solution()

		"teamwork":
			# BIZARRE solution - Party teamwork
			await C.player.say("Let's work TOGETHER!")
			await E.queue([
				"Pig: Now that's usin' your head.",
			])
			stop()
			await R.PuertoRico.execute_boat_bizarre_solution()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
