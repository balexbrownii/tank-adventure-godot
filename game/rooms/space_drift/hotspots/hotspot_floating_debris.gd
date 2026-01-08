@tool
extends PopochiuHotspot
## Floating Debris hotspot - Space junk from the explosion. Can collect Debris Trinket.

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.debris_collected:
		await C.player.say("I already grabbed the shiniest piece!")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await _tank_vision_interaction()
	else:
		await _reality_vision_interaction()


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["floating_debris"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I'd rather not add to the debris field.")


#endregion

#region Private ####################################################################################
func _tank_vision_interaction() -> void:
	await C.player.say("SPACE TREASURE!")
	await C.player.say("Ooh, that piece is extra shiny!")

	await D.TakeDebris.start()


func _reality_vision_interaction() -> void:
	await C.player.say("Debris from the explosion. Some of it looks salvageable.")
	await C.player.say("That piece might be useful...")

	await D.TakeDebris.start()


#endregion
