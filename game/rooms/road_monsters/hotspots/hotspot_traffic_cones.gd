@tool
extends PopochiuHotspot
## Traffic Cones hotspot - "Warning Totems"
## Can be picked up and used for the BRAINS solution.


#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	await C.player.walk_to_clicked()
	await C.player.face_clicked()

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await E.queue([
			"Tank: Warning totems!",
			"Tank: The survivors who came before left these markers.",
			"Tank: I should heed their wisdom... or use them!"
		])
	else:
		await C.player.say("Traffic cones. They redirect cars away from hazards.")

	if room.state.solution_used == "":
		# Offer to pick up
		await C.player.say("I could take these.")
		D.TakeCones.start()


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["traffic_cones"])
	await C.player.face_clicked()
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I should just pick up the cones.")


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
		await C.player.say("Oh wise totems, guide my path!")
		await C.player.say("...they remain silent.")
	else:
		await C.player.say("They're traffic cones. They can't talk.")


func on_pick_up() -> void:
	await _on_click()


#endregion

#region Public Methods #####################################################################################
## Pick up the cones for inventory
func pick_up_cones() -> void:
	await E.queue([
		"Tank: Got them!",
		"Tank picks up the traffic cones"
	])
	I.Cone.add()


## Use cones to redirect traffic (BRAINS solution)
func use_for_redirect() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	await room.execute_brains_solution()


#endregion
