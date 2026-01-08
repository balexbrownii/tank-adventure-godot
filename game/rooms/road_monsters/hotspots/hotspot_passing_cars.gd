@tool
extends PopochiuHotspot
## Passing Cars hotspot - Tank sees them as "MONSTERS"
## This is the main puzzle trigger for the BRAWN solution.


#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	if room.state.solution_used != "":
		await C.player.say("The monsters have been dealt with.")
		return

	# Different interaction based on vision mode
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await _tank_vision_interaction()
	else:
		await _reality_vision_interaction()


func _on_right_click() -> void:
	# Look at - uses vision system
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["passing_cars"])
	await C.player.face_clicked()
	await C.player.say(inspect)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == "TrafficCones" or item.script_name == "Cone":
		# Using cones on cars - redirect solution hint
		await C.player.say("I could use these to redirect the monster herd...")
	else:
		await C.player.say("I don't think that'll help with the monsters.")


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
		await C.player.say("HEY MONSTERS! STOP EATING PEOPLE!")
		await C.player.say("...they're not listening.")
	else:
		await C.player.say("I can't talk to cars.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("I'll pick up a monster!")
		await _on_click()
	else:
		await C.player.say("I can't pick up a moving car!")


#endregion

#region Private ####################################################################################
func _tank_vision_interaction() -> void:
	# In Tank Vision, offer the heroic (dumb) option
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Those poor citizens! The monsters are eating them!")

	# Show approach options
	await D.RoadMonstersApproach.start()


func _reality_vision_interaction() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	room.state.cars_examined_reality = true

	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("They're just... cars.")
	await C.player.say("People driving places.")
	await C.player.say("...but why do they roar so angrily?")

	# Increase ignorance since Tank is learning truth
	GameState.modify_ignorance(5)


#endregion
