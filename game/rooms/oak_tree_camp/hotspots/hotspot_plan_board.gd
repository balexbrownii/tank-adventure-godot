@tool
extends PopochiuHotspot
## Plan board hotspot - Shows the route plan (tutorial for quest system)

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if not room.state.breakfast_done:
		await C.player.say("Pig said to wait until after breakfast.")
		return

	if room.state.route_sketch_received:
		await C.player.say("I already have the route sketch!")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("THE MAP TO CANADA!")
		await C.player.say("Step 1: Go! Step 2: Keep going! Step 3: WIN!")
		room.state.plan_examined_reality = false
	else:
		await C.player.say("Pig's detailed route plan.")
		await C.player.say("Brazil coast, then across the Caribbean to Puerto Rico...")
		await C.player.say("Then Florida, and north to Canada.")
		room.state.plan_examined_reality = true
		GameState.modify_ignorance(2)

	if not room.state.route_sketch_received:
		await room._complete_planning()


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["plan_board"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The plan board doesn't need anything added.")


#endregion
