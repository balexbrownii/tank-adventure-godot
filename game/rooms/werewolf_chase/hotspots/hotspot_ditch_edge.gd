@tool
extends PopochiuHotspot
## Ditch edge hotspot - Safety / escape destination

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WerewolfChase
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("A MYSTERIOUS HOLE!")
		await C.player.say("A portal to adventure!")
		await C.player.say("Or safety! Same thing!")
	else:
		await C.player.say("A deep ditch.")
		await C.player.say("If I jump in, the wolf might not be able to follow.")

	if room.state.chase_started and not room.state.escaped:
		await C.player.say("I need to get there! But the wolf is in the way!")


func _on_right_click() -> void:
	var room = R.WerewolfChase
	var inspect = TankVision.get_inspect_text(room.vision_data["ditch_edge"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I just need to get there!")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	var room = R.WerewolfChase
	var inspect = TankVision.get_inspect_text(room.vision_data["ditch_edge"])
	await C.player.say(inspect)


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I need to jump in! Escape the wolf!")
	await _on_click()


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Ditch! Catch me if I fall!")
	await C.player.say("Be a good ditch!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a whole ditch!")
	await C.player.say("...Or can I?")
	await C.player.say("No, probably not.")


#endregion
