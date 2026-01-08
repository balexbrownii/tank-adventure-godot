@tool
extends PopochiuHotspot
## Police Siren hotspot - Audio hotspot showing pursuit is coming.

#region Virtual ####################################################################################
func _on_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("The ANGRY LIGHTS are getting closer!")
		await C.player.say("They must be backup for the monsters!")
		await C.player.say("I need to leave NOW!")
	else:
		await C.player.say("Police sirens. They're definitely coming this way.")
		await C.player.say("I should hurry up and get out of here.")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["police_siren"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't do anything about the sirens from here.")
	await C.player.say("I just need to LEAVE.")


#endregion
