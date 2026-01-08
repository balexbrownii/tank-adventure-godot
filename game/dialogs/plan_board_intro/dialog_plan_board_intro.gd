@tool
extends PopochiuDialog
## Dialog for the plan board introduction.
## Shows the route and gives the Route Sketch item.


#region Virtual ####################################################################################
func _on_start() -> void:
	await E.queue([
		"Pig: Here's the route.",
		"Pig: First, we head to the Brazil coast.",
		"Pig: Then we build a raft and cross the Caribbean.",
		"Tank: That sounds WET.",
		"Pig: It's the sea. Yes, it's wet.",
		"Pig: We land in Puerto Rico, rest up, then sail to Florida.",
		"Tank: Florida! I've heard of that!",
		"Pig: From there, we go north. All the way to Canada.",
		"Tank: CANADA!",
		"Mr. Snuggles nods approvingly"
	])


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"sounds_good":
			await C.player.say("Let's do it!")
			stop()
			await R.OakTreeCamp._complete_planning()

		"any_dangers":
			await C.player.say("Are there dangers?")
			await E.queue([
				"Pig: Probably.",
				"Pig: Germans are still after you.",
				"Pig: And that werewolf you mentioned.",
				"Tank: The WOLF...",
				"Pig: Plus, y'know, the sea. And customs. And weather.",
				"Tank: We'll DEFEAT them all!",
				"Pig: That's... one approach."
			])
			_show_options()

		"why_canada":
			await C.player.say("Why Canada?")
			await E.queue([
				"Pig: That's where Mr. Snuggles' herd is.",
				"Pig: Plus I got a cousin there who owes me money.",
				"Tank: What about me?",
				"Pig: What ABOUT you?",
				"Tank: I... don't remember why I'm going to Canada.",
				"Tank: But it FEELS important!",
				"Pig: Good enough reason as any, I suppose."
			])
			_show_options()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
