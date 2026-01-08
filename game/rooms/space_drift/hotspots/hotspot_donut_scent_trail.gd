@tool
extends PopochiuHotspot
## Donut Scent Trail hotspot - Tank can smell donuts pointing toward Earth.
## This enables the Brawn solution (swim rhythm).

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await _tank_vision_interaction()
	else:
		await _reality_vision_interaction()

	room.state.donut_trail_found = true


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["donut_scent_trail"])
	await C.player.say(inspect)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == "DonutBox":
		await C.player.say("My donuts are resonating with the trail!")
		await C.player.say("They want to lead me home!")
		# Hint that donuts help with this approach
		var room = get_parent().get_parent().get_parent() as PopochiuRoom
		room.state.donut_trail_found = true
	else:
		await C.player.say("That won't help me follow the scent.")


#endregion

#region Private ####################################################################################
func _tank_vision_interaction() -> void:
	await C.player.say("DONUT COMPASS!")
	await C.player.say("*sniff sniff*")
	await C.player.say("I can smell glazed... and chocolate... and the jelly-filled ones!")
	await C.player.say("They're all pointing the same way - HOME!")

	# If player has DonutBox, extra dialogue
	if I.DonutBox.is_in_inventory():
		await C.player.say("My donuts are getting excited! They recognize the scent!")


func _reality_vision_interaction() -> void:
	await C.player.say("There's some kind of particle trail here...")
	await C.player.say("Probably debris from the explosion.")
	await C.player.say("But wait... is that... sugar particles?")

	# Tank can't help herself
	await C.player.say("IT SMELLS LIKE DONUTS!")
	GameState.modify_ignorance(-2)  # Tank's donut obsession overcomes rationality


#endregion
