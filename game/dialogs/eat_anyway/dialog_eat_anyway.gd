@tool
extends PopochiuDialog
## Dialog after discovering the food is poisonous.
## Player now has a choice: eat anyway (fail-forward) or don't eat (strategic).
## Demonstrates consequences of increasing Ignorance meter.


#region Virtual ####################################################################################
func _on_start() -> void:
	await E.queue([
		"*You now know the food is poisonous*",
		"*Your Ignorance has increased...*",
	])
	await C.player.say("Those mushrooms are... poisonous?!")
	await C.player.say("But I'm so HUNGRY!")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"eat_anyway":
			# FAIL-FORWARD - Eat knowing it's poison (gets sick)
			await C.player.say("I don't care! I'm eating it!")
			stop()
			await R.PoisonPicnic.execute_fail_forward()

		"dont_eat":
			# Strategic choice - Save as bait
			await C.player.say("No... I'll save this for later...")
			await C.player.say("Maybe I can use it on enemies!")
			stop()
			await R.PoisonPicnic.execute_bizarre_solution()

		"tell_tank":
			# "Tell Tank" mechanic - Permanently increases Ignorance
			await C.player.say("Wait... I need to understand this...")
			stop()
			await R.PoisonPicnic.tell_tank_about_poison()
			# Show options again after learning
			start()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
