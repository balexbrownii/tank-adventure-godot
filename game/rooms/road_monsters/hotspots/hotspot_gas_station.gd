@tool
extends PopochiuHotspot
## Gas Station hotspot - the "Monster Lair"
## Has map flyers that can be collected.


#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	await C.player.walk_to_clicked()
	await C.player.face_clicked()

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("The monster lair! They rest here between hunts!")
		await C.player.say("I should be careful...")
	else:
		if not "map_flyer" in room.state.items_collected:
			await E.queue([
				"Tank: Just a gas station.",
				"Tank: Oh, there are map flyers by the door."
			])
			# Offer to take map
			D.TakeMapFlyer.start()
		else:
			await C.player.say("Normal gas station. Nothing special.")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["gas_station"])
	await C.player.face_clicked()
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to use that here.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await _on_right_click()


func on_use() -> void:
	await _on_click()


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("Hello monster lair! Are you... friendly?")
		await C.player.say("Probably not.")
	else:
		await C.player.say("It's a building. It can't talk.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up an entire building!")
	await C.player.say("...or CAN I?")
	await C.player.say("No. Definitely not.")


#endregion
