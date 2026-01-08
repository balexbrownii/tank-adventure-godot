@tool
extends PopochiuHotspot
## Road Sign hotspot - Can take the arrow for the Bizarre solution.

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.sign_arrow_taken:
		await C.player.say("I already took the arrow from this.")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await _tank_vision_interaction()
	else:
		await _reality_vision_interaction()


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["road_sign"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to put anything on the sign.")


#endregion

#region Private ####################################################################################
func _tank_vision_interaction() -> void:
	await C.player.say("A DIRECTION TOTEM!")
	await C.player.say("It points... that way! Wisdom!")

	await D.TakeSignArrow.start()


func _reality_vision_interaction() -> void:
	await C.player.say("A road sign. The arrow looks like it could be removed...")
	await C.player.say("Might make a decent lever or tool.")

	await D.TakeSignArrow.start()


#endregion
