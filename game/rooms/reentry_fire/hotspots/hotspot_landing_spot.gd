@tool
extends PopochiuHotspot
## Landing Spot hotspot - Where Tank crashed from space.

#region Virtual ####################################################################################
func _on_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("MY CRATER! I made this!")
		await C.player.say("It's still warm. And me-shaped.")
	else:
		await C.player.say("The impact site. Still smoldering.")
		await C.player.say("I should probably not stay here too long...")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["landing_spot"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to leave anything at my crash site.")


#endregion
