@tool
extends PopochiuDialog
## Dialog: Make Camp
## The main puzzle dialog for Room 3 - choosing how to set up camp


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("I need to make camp for the night.")
	await C.player.say("How should I set up my sleeping spot?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"use_leaves":
			# Standard solution
			await C.player.say("I'll use these leaves as a blanket!")
			stop()
			await R.DitchHideout.execute_standard_solution()

		"craft_better":
			# Brains solution - requires both items
			if I.LeafBlanket.is_in_inventory() and I.RootFiber.is_in_inventory():
				await C.player.say("I can weave the roots through the leaves for a better blanket!")
				I.LeafBlanket.remove()
				I.RootFiber.remove()
				stop()
				await R.DitchHideout.execute_brains_solution()
			elif I.LeafBlanket.is_in_inventory():
				await C.player.say("I'd need some root fiber to weave into this...")
			elif I.RootFiber.is_in_inventory():
				await C.player.say("I'd need some leaves to weave these into...")
			else:
				await C.player.say("I'd need leaves AND roots to craft something better...")

		"punch_ground":
			# Brawn solution
			await C.player.say("Who needs blankets? I'll MAKE a comfortable bed!")
			stop()
			await R.DitchHideout.execute_brawn_solution()

		"skip_camp":
			# Fail-forward
			await C.player.say("Sleep is for the WEAK! I'll just lie down wherever!")
			stop()
			await R.DitchHideout.execute_fail_forward()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
