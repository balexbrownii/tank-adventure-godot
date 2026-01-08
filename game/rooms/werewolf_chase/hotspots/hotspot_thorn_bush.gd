@tool
extends PopochiuHotspot
## Thorn bush hotspot - Sharp thorns for collecting

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WerewolfChase
	if room.state.thorn_taken:
		await C.player.say("I already got a thorn.")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("ANGRY PLANT!")
		await C.player.say("Why is it so pointy?!")
		await C.player.say("Maybe it needs a hug!")
		await E.queue([
			"Tank reaches toward the bush",
			"POKE!",
			"Tank: OW! Rude!"
		])
	else:
		await C.player.say("Sharp thorns.")
		await C.player.say("Could be useful as a tool... or weapon.")

	# Start take thorn dialog
	await D.TakeThorn.start()


func _on_right_click() -> void:
	var room = R.WerewolfChase
	var inspect = TankVision.get_inspect_text(room.vision_data["thorn_bush"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The bush doesn't need anything.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	var room = R.WerewolfChase
	var inspect = TankVision.get_inspect_text(room.vision_data["thorn_bush"])
	await C.player.say(inspect)


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await _on_click()


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Why so angry, pointy bush?")
	await C.player.say("Did someone hurt you?")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await _on_click()


#endregion
