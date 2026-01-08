@tool
extends PopochiuHotspot
## Donut Box hotspot - Temptation item. Optional morale boost.

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.donut_box_taken:
		await C.player.say("I already have those donuts!")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await _tank_vision_interaction()
	else:
		await _reality_vision_interaction()


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["donut_box"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I shouldn't mix things with my precious donuts.")


#endregion

#region Private ####################################################################################
func _tank_vision_interaction() -> void:
	await C.player.say("DONUTS! REAL EARTH DONUTS!")
	await C.player.say("I KNEW following the donut smell would pay off!")

	await D.TakeDonutsReentry.start()


func _reality_vision_interaction() -> void:
	await C.player.say("A discarded box of donuts. Still looks fresh.")
	await C.player.say("Someone's loss is my gain!")

	await D.TakeDonutsReentry.start()


#endregion
