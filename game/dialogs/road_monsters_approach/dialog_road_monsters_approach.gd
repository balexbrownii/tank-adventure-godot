@tool
extends PopochiuDialog
## Main approach choice dialog for Road of Monsters puzzle.
## Presents the three approaches: Brawn (save citizens), Brains (redirect), Bizarre (explosion)


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.say("What should I do about these monsters?")


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"save_citizens":
			# BRAWN solution - Tank lifts a car
			await C.player.say("I'll save those poor people!")
			stop()
			# Get the room and execute brawn solution
			await R.RoadMonsters.execute_brawn_solution()

		"redirect_monsters":
			# BRAINS solution - Use cones to redirect traffic
			await C.player.say("If I can redirect the monster herd away from the citizens...")
			stop()
			# Check if player has cones
			if I.Cone.is_in_inventory():
				await R.RoadMonsters.execute_brains_solution()
			else:
				await C.player.say("I need something to redirect them with... those warning totems, maybe?")
				_show_options()

		"observe_carefully":
			# Hints at BIZARRE solution
			await C.player.say("Let me look more carefully at this place...")
			stop()
			await C.player.say("There's something leaking over there... and sparks...")
			# Player needs to investigate hotspots to find bizarre solution

		"just_watch":
			# Passive option - still results in explosion eventually
			await C.player.say("Maybe I should just... watch?")
			stop()
			await C.player.say("...")
			await C.player.say("No. I can't just watch people get eaten!")
			_show_options()

		_:
			stop()


func _on_save() -> Dictionary:
	return {}


func _on_load(_data: Dictionary) -> void:
	pass


#endregion
