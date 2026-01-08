@tool
extends PopochiuHotspot
## Motorcycle (parked) hotspot - Tank's ride, now stopped.

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("My trusty metal horse! Good horse!")
		await C.player.say("You stopped when I needed you to. Mostly.")
	else:
		await C.player.say("The motorcycle. Still warm from the ride.")
		await C.player.say("I should probably learn how brakes work.")

	if not room.state.pig_joined:
		await C.player.say("I should talk to that pig before leaving.")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["motorcycle"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The motorcycle doesn't need anything right now.")


#endregion
