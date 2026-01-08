@tool
extends PopochiuDialog
## Main recruitment dialog for Pig.
## Three approaches: Respect (Brains), Bribe (Bizarre), Intimidate (Brawn)


#region Virtual ####################################################################################
func _on_start() -> void:
	var room = R.PigDeerCrossing as PopochiuRoom

	if room.state.pig_mood == "angry":
		await C.player.say("The pig looks REALLY mad at me...")
	else:
		await C.player.say("Maybe I can talk to the pig now...")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"apologize":
			# BRAINS solution - Apologize and offer help
			await C.player.say("I want to say sorry...")
			stop()
			await R.PigDeerCrossing.execute_brains_solution()

		"offer_donuts":
			# BIZARRE solution - Bribe with donuts
			if I.DonutBox.is_in_inventory():
				await C.player.say("I have a peace offering!")
				stop()
				await R.PigDeerCrossing.execute_bizarre_solution()
			else:
				await C.player.say("I wish I had something to offer...")
				await C.player.say("Wait, maybe I'll find donuts later!")
				_show_options()

		"intimidate":
			# BRAWN solution - Flex and demand
			await C.player.say("Maybe I should show who's boss!")
			stop()
			await R.PigDeerCrossing.execute_brawn_solution()

		"ignore":
			# Fail-forward path
			await C.player.say("Maybe I'll just... wait?")
			stop()
			var room = R.PigDeerCrossing as PopochiuRoom
			if not room.state.strap_task_given:
				await E.queue([
					"Pig: You're just gonna STAND there?!",
					"Pig: Fine! If you want to make yourself useful..."
				])
				await R.PigDeerCrossing.execute_fail_forward()
			else:
				await C.player.say("I should probably do what the pig asked.")

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
