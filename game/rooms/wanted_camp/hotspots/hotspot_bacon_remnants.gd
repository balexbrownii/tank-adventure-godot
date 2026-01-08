@tool
extends PopochiuHotspot
## Bacon remnants hotspot - Crumbs from the commander's sandwich

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WantedCamp
	if room.state.bacon_crumbs_taken:
		await C.player.say("I already got the crumbs.")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("DELICIOUS MEMORIES!")
		await C.player.say("The remains of the BEST sandwich ever!")
	else:
		await C.player.say("Crumbs from the commander's sandwich.")
		await C.player.say("Still smells strongly of bacon...")

	await E.queue([
		"Tank carefully collects the bacon crumbs",
		"Tank: These could be useful! Or a snack!",
		"Tank: Probably a snack."
	])

	I.BaconCrumbs.add_to_inventory()
	room.state.bacon_crumbs_taken = true


func _on_right_click() -> void:
	var room = R.WantedCamp
	var inspect = TankVision.get_inspect_text(room.vision_data["bacon_remnants"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("These crumbs don't need anything else.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	var room = R.WantedCamp
	var inspect = TankVision.get_inspect_text(room.vision_data["bacon_remnants"])
	await C.player.say(inspect)


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't use crumbs like that.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Dear crumbs, you were once part of something beautiful.")
	await C.player.say("Rest now, little bacon bits.")


func on_pick_up() -> void:
	await _on_click()


#endregion
