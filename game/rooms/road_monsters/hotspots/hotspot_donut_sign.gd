@tool
extends PopochiuHotspot
## Donut Display Sign hotspot - "Sacred Ring"
## Donuts can be obtained, especially with BRAINS solution.


#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	await C.player.walk_to_clicked()
	await C.player.face_clicked()

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await E.queue([
			"Tank: A sacred ring of power!",
			"Tank: It glows with an inner light!",
			"Tank: The smell... it calls to me..."
		])
	else:
		await E.queue([
			"Tank: Donut display. Fresh ones inside.",
			"Tank: They smell amazing."
		])

	if not "donut_box" in room.state.items_collected and room.state.solution_used == "":
		await C.player.say("I want those. But there's so much chaos right now...")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["donut_sign"])
	await C.player.face_clicked()
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't reach the donuts from here.")


#endregion
