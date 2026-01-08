@tool
extends PopochiuDialog
## Dialog for the fail-forward strap fix task.


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("How do I fix this strap?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"pull_tight":
			await C.player.say("Let me just pull it tight...")
			stop()
			await R.PigDeerCrossing.complete_strap_fix()

		"tie_knot":
			await C.player.say("I'll tie it in a knot!")
			stop()
			await E.queue([
				"Tank ties an impressive knot",
				"Pig: That's... actually a good knot.",
				"Tank: I learned it from a book!",
				"Pig: You can read?",
				"Tank: Pictures count!"
			])
			await R.PigDeerCrossing.complete_strap_fix()

		"punch_it":
			await C.player.say("MAYBE IF I PUNCH IT-")
			stop()
			await E.queue([
				"Pig: NO! Don't punch the deer!",
				"Tank: I wasn't going to punch the deer!",
				"Tank: ...Much.",
				"Mr. Snuggles remains unfazed"
			])
			_show_options()

		"give_up":
			await C.player.say("This is too hard...")
			stop()
			await E.queue([
				"Pig: It's just a STRAP!",
				"Pig: Just pull it and loop it!",
				"Tank: Oh! Like THIS?"
			])
			await R.PigDeerCrossing.complete_strap_fix()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
