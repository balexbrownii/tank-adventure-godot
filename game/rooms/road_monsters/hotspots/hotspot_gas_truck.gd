@tool
extends PopochiuHotspot
## Gas Truck hotspot - the "Mother Monster"
## Part of the bizarre solution path.


#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	await C.player.walk_to_clicked()
	await C.player.face_clicked()

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await E.queue([
			"Tank: The QUEEN monster!",
			"Tank: She's huge! She must command all the others!",
			"Tank: I... I'm not sure I can take her alone."
		])
	else:
		await E.queue([
			"Tank: A fuel delivery truck.",
			"Tank: The connection to the station looks loose."
		])

		if room.state.solution_used == "":
			await C.player.say("That could be dangerous if something sparked...")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["gas_truck"])
	await C.player.face_clicked()
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("I shouldn't anger the queen monster with trinkets!")
	else:
		await C.player.say("I probably shouldn't mess with a fuel truck.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await _on_right_click()


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I'll throw something at the queen monster!")
	await C.player.say("TAKE THIS!")
	await E.queue([
		"*KABOOOOOM*",
		"Tank is launched into the air by the explosion!",
		"Tank: WHEEEEEEEEEEE!",
	])
	E.goto_room("SpaceDrift")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("Oh great queen monster!")
		await C.player.say("Please spare me!")
		await C.player.say("...she's not responding.")
	else:
		await C.player.say("It's a truck. Trucks don't talk.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("I'm strong but I'm not THAT strong!")
	else:
		await C.player.say("Even I can't lift a fuel truck.")


#endregion
