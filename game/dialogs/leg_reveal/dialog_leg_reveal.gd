@tool
extends PopochiuDialog
## Dialog: Leg Reveal
## The main puzzle dialog for Room 4 - discovering Tank's leg isn't actually gone
## THIS IS THE VISION TOGGLE TUTORIAL


#region Virtual ####################################################################################
func _on_start() -> void:
	# Check vision mode for different intro
	if TankVision.is_reality_mode:
		await C.player.say("Wait... there's definitely something under those leaves...")
	else:
		await C.player.say("My leg... my beautiful leg... GONE FOREVER!")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"examine_pile":
			# Brains solution - pull leaves away
			await C.player.say("Let me look at this more carefully...")
			stop()
			await R.MorningMiracle.execute_brains_solution()

		"pretend_struggle":
			# Brawn solution - fall into pile
			await C.player.say("I will OVERCOME this disability!")
			stop()
			await R.MorningMiracle.trigger_pretend_struggle()

		"scream_miracle":
			# Bizarre solution - scream for miracle
			await C.player.say("I must SUMMON my leg back!")
			stop()
			await R.MorningMiracle.trigger_scream_miracle()

		"give_up":
			# Fail-forward
			await C.player.say("I... I just can't face this...")
			stop()
			await R.MorningMiracle.execute_fail_forward()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
