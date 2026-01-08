@tool
extends PopochiuHotspot
## Spark Source (Exposed Wiring) hotspot - "Tiny Fire Spirit"
## Part of the BIZARRE solution - combine with leaking pump.


#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	await C.player.walk_to_clicked()
	await C.player.face_clicked()

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await E.queue([
			"Tank: A tiny fire spirit!",
			"Tank: It blinks and dances!",
			"Tank: Should I... free it?"
		])

		# In Tank Vision, offer to "free the fire spirit" - triggers bizarre solution
		if room.state.solution_used == "":
			D.FireSpiritChoice.start()
	else:
		await E.queue([
			"Tank: Exposed electrical wiring.",
			"Tank: That's sparking. Very dangerous near the gas leak."
		])

		# In Reality Vision, offer to "cause accident" - triggers bizarre solution
		if room.state.solution_used == "":
			D.AccidentChoice.start()


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["spark_source"])
	await C.player.face_clicked()
	await C.player.say(inspect)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == "Cone" or item.script_name == "TrafficCones":
		await C.player.say("I can't cover electrical problems with traffic cones.")
	elif item.script_name == "Water" or item.script_name == "WaterBottle":
		# Attempt to "fix" the problem
		var room = get_parent().get_parent().get_parent() as PopochiuRoom
		await room.execute_fail_forward()
	else:
		await C.player.say("I shouldn't touch electrical stuff with random items.")


#endregion
