@tool
extends PopochiuDialog
## Dialog for food choice - the main Poison Picnic puzzle.
## THIS IS THE IGNORANCE MECHANIC TUTORIAL!
## Tank can eat poison safely IF she doesn't know it's poison.


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("Time for breakfast!")
	await C.player.say("What should I do with these adventure snacks?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"just_eat":
			# IGNORANCE solution - Eat without examining!
			# This is the "correct" funny solution
			await C.player.say("FOOD TIME!")
			stop()
			await R.PoisonPicnic.execute_ignorance_solution()

		"examine_food":
			# BRAINS solution - Examine carefully (increases Ignorance!)
			await C.player.say("Hmm... let me look at these more carefully...")
			stop()
			await R.PoisonPicnic.execute_brains_solution()

		"save_bait":
			# BIZARRE solution - Don't eat, save as bait
			await C.player.say("Wait... I have a BETTER idea!")
			stop()
			await R.PoisonPicnic.execute_bizarre_solution()

		"ask_birds":
			# Silly option - ask the "sky companions"
			await C.player.say("Hey! Sky friends!")
			await C.player.say("Is this food good?")
			await E.queue([
				"*The birds circle lower*",
				"*They seem very interested in the food*",
				"*And you*",
			])
			await C.player.say("They want me to eat! Good sign!")
			# Goes back to options

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
