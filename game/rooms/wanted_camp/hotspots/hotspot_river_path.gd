@tool
extends PopochiuHotspot
## River path hotspot - Trail leading to the river (escape route)

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WantedCamp
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("WATER ROAD!")
		await C.player.say("The path leads to water! Water is good!")
	else:
		await C.player.say("A trail leading to the river.")
		await C.player.say("Possible escape route.")

	if not room.state.soldiers_arrived:
		await C.player.say("I should gather supplies before leaving.")
	else:
		await C.player.say("Time to go!")


func _on_right_click() -> void:
	var room = R.WantedCamp
	var inspect = TankVision.get_inspect_text(room.vision_data["river_path"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to use anything on the path.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	var room = R.WantedCamp
	var inspect = TankVision.get_inspect_text(room.vision_data["river_path"])
	await C.player.say(inspect)


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	var room = R.WantedCamp
	if room.state.soldiers_arrived:
		await C.player.say("Time to escape!")
		# This would trigger the escape sequence
	else:
		await C.player.say("I should gather supplies before heading out.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Where do you lead, mysterious path?")
	await C.player.say("To adventure! And maybe water!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a path. That's silly.")
	await C.player.say("...")
	await C.player.say("Even for me.")


#endregion
