@tool
extends PopochiuDialog
## Dialog for soldier encounter.
## Three approaches: Brawn (fight), Brains (bacon lure), Bizarre (Bacon Guardians)


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("What should I do about these soldiers?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"fight_them":
			# BRAWN solution - Combat combo
			await C.player.say("TIME FOR ACTION!")
			stop()
			await R.WantedCamp.execute_brawn_solution()

		"bacon_lure":
			# BRAINS solution - Distract with bacon
			if not I.BaconCrumbs.is_in_inventory():
				await C.player.say("I need some bacon crumbs for that...")
				return
			await C.player.say("I have an idea...")
			stop()
			await R.WantedCamp.execute_brains_solution()

		"bacon_guardians":
			# BIZARRE solution - Declare them Bacon Guardians
			await C.player.say("Wait! I know who you are!")
			stop()
			await R.WantedCamp.execute_bizarre_solution()

		"surrender":
			# Fail-forward path
			await C.player.say("I... don't know what to do!")
			stop()
			await R.WantedCamp.execute_fail_forward()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
