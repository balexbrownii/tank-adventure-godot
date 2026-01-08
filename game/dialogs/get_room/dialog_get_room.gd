@tool
extends PopochiuDialog
## Dialog for getting a motel room in Puerto Rico.
## Three solutions: Trade (Brains), Charm (Bizarre), Intimidate (Brawn).


#region Virtual ####################################################################################
func _on_start() -> void:
	await E.queue([
		"Clerk: Can I help you?",
		"Tank: WE NEED REST!",
		"Clerk: *eyes the odd group* ...okay.",
	])


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"trade":
			# BRAINS solution - Trade goods
			await C.player.say("We can trade for the room!")
			stop()
			await R.PuertoRico.execute_room_brains_solution()

		"charm":
			# BIZARRE solution - Cute deer charm
			await C.player.say("Mr. Snuggles, do your thing!")
			stop()
			await R.PuertoRico.execute_room_bizarre_solution()

		"intimidate":
			# BRAWN solution - Tank intimidates
			await C.player.say("I'll CONVINCE them!")
			stop()
			await R.PuertoRico.execute_room_brawn_solution()

		"leave":
			# FAIL-FORWARD - Give up
			await C.player.say("Never mind, we'll figure something out...")
			stop()
			await R.PuertoRico.execute_room_fail_forward()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
