@tool
extends PopochiuDialog
## Dialog for werewolf chase approach.
## Three approaches: Brawn (fast run), Brains (decoy), Bizarre (honorable duel)


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("The wolf is RIGHT BEHIND ME!")
	await C.player.say("What do I do?!")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"run_fast":
			# BRAWN solution - Fast running sequence
			await C.player.say("MAXIMUM SPEED!")
			stop()
			await R.WerewolfChase.execute_brawn_solution()

		"decoy":
			# BRAINS solution - Create distraction
			await C.player.say("I need to distract it...")
			stop()
			await R.WerewolfChase.execute_brains_solution()

		"duel":
			# BIZARRE solution - Challenge to duel
			if TankVision.current_mode == TankVision.VisionMode.TANK:
				await C.player.say("ARCH NEMESIS!")
				stop()
				await R.WerewolfChase.execute_bizarre_solution()
			else:
				await C.player.say("That's... that's a werewolf.")
				await C.player.say("I can't duel a werewolf!")
				# Stay in dialog

		"panic":
			# Fail-forward path
			await C.player.say("I DON'T KNOW!")
			stop()
			await R.WerewolfChase.execute_fail_forward()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
