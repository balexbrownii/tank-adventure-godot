@tool
extends PopochiuHotspot
## Leaking Gas Pump hotspot - "Monster Blood"
## Part of the BIZARRE solution - combine with spark source.


#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	await C.player.walk_to_clicked()
	await C.player.face_clicked()

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await E.queue([
			"Tank: The monster's lair is bleeding!",
			"Tank: Dark blood seeps from its wounds!",
			"Tank: This is a sign of weakness!"
		])
	else:
		await E.queue([
			"Tank: Gasoline is leaking from this pump.",
			"Tank: Very dangerous. One spark and..."
		])

		# Hint at the bizarre solution
		if room.state.solution_used == "":
			await C.player.say("I should probably stay away from any ignition sources.")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["leaking_pump"])
	await C.player.face_clicked()
	await C.player.say(inspect)


func _on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == "Match" or item.script_name == "Lighter":
		# Direct ignition attempt - trigger fail-forward
		var room = get_parent().get_parent().get_parent() as PopochiuRoom
		await room.execute_bizarre_solution()
	else:
		await C.player.say("I don't want to make the leak worse.")


#endregion
