@tool
extends PopochiuHotspot
## Split trail sign hotspot - Crooked arrows pointing everywhere

#region Virtual ####################################################################################
func _on_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("HELPFUL ARROWS!")
		await C.player.say("They point... everywhere!")
		await C.player.say("All directions are good directions!")
	else:
		await C.player.say("A crooked trail sign.")
		await C.player.say("Hard to tell which way is actually safe.")


func _on_right_click() -> void:
	var room = R.WerewolfChase
	var inspect = TankVision.get_inspect_text(room.vision_data["split_trail_sign"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("No time for that! RUNNING!")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await _on_click()


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("No time to use things! THE WOLF!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Which way, sign?!")
	await C.player.say("It points... everywhere. Not helpful!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("No time to pick things up! RUNNING!")


#endregion
