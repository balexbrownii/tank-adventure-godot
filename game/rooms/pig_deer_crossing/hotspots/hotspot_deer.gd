@tool
extends PopochiuHotspot
## Deer (Mr. Snuggles) hotspot - Can be used for fail-forward strap fix.

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.pig_joined:
		await C.player.say("Mr. Snuggles seems happy to travel with us!")
		await C.player.say("He's so CALM!")
		return

	if room.state.strap_task_given and not room.state.strap_fixed:
		# Player needs to fix the strap
		await _fix_strap_interaction()
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("The fluffiest horse! So serene!")
		await C.player.say("It just... stares at me. Peacefully.")
	else:
		room.state.deer_examined = true
		await C.player.say("A deer. Remarkably calm given I almost ran it over.")
		await C.player.say("It's wearing a tiny saddle. The pig rides it?")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["deer"])
	await C.player.say(inspect)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.strap_task_given and not room.state.strap_fixed:
		# Any item could potentially fix the strap
		if item.script_name == "RoadSignArrow" or item.script_name == "Cone":
			await C.player.say("Let me try using this on the strap...")
			await room.complete_strap_fix()
		else:
			await C.player.say("Hmm, that's not quite right for fixing a strap.")
	else:
		await C.player.say("Mr. Snuggles doesn't need that.")


#endregion

#region Private ####################################################################################
func _fix_strap_interaction() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	await C.player.say("The saddle strap looks loose...")
	await C.player.say("I think I can tighten it.")

	await D.FixStrap.start()


#endregion
