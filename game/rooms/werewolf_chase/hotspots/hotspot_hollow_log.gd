@tool
extends PopochiuHotspot
## Hollow log hotspot - Can crawl through for escape

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WerewolfChase
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("A NATURE TUNNEL!")
		await C.player.say("Secret passages are the BEST!")
	else:
		await C.player.say("A hollow log.")
		await C.player.say("I could crawl through it to escape.")

	# Can take bark
	if not room.state.hollow_log_bark_taken:
		await E.queue([
			"Tank notices some loose bark on the log",
			"Tank: This bark looks useful!"
		])
		I.HollowLogBark.add_to_inventory()
		room.state.hollow_log_bark_taken = true


func _on_right_click() -> void:
	var room = R.WerewolfChase
	var inspect = TankVision.get_inspect_text(room.vision_data["hollow_log"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The log is fine as is!")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	var room = R.WerewolfChase
	var inspect = TankVision.get_inspect_text(room.vision_data["hollow_log"])
	await C.player.say(inspect)


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I could crawl through this!")
	await _on_click()


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello, nature tunnel!")
	await C.player.say("Thank you for being hollow!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await _on_click()


#endregion
