@tool
extends PopochiuHotspot
## Bush line hotspot - Dense bushes for hiding

#region Virtual ####################################################################################
func _on_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("FLUFFY HIDING PLACE!")
		await C.player.say("Perfect for hiding! Or napping!")
		await E.queue([
			"Tank considers crawling into the bushes",
			"Tank: So cozy looking...",
			"Tank: But I should probably stay by the fire."
		])
	else:
		await C.player.say("Thick bushes. Good cover for sneaking.")
		await C.player.say("Could hide in there if needed.")


func _on_right_click() -> void:
	var room = R.WantedCamp
	var inspect = TankVision.get_inspect_text(room.vision_data["bush_line"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	match _item.script_name:
		"BaconCrumbs":
			await E.queue([
				"Tank sprinkles bacon crumbs near the bushes",
				"Tank: A trap for bacon lovers!",
				"Tank: Or a gift for the bush spirits!"
			])
		_:
			await C.player.say("The bushes don't need that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	var room = R.WantedCamp
	var inspect = TankVision.get_inspect_text(room.vision_data["bush_line"])
	await C.player.say(inspect)


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("I'll dive into the fluffy bushes!")
		await E.queue([
			"Tank dives headfirst into the bushes",
			"...",
			"Tank: Ow. Less fluffy than expected."
		])
	else:
		await C.player.say("I could hide in there if needed.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello bushes! Are there any forest friends in there?")
	await C.player.say("...")
	await C.player.say("Guess not. Or they're hiding really well!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up an entire line of bushes.")
	await C.player.say("Well, I probably COULD, but it seems excessive.")


#endregion
