@tool
extends PopochiuHotspot
## Spinach leaves hotspot - Mr. Snuggles' food

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("GREEN POWER LEAVES!")
		await C.player.say("Mr. Snuggles eats these and becomes SUPER FLUFFY!")
	else:
		await C.player.say("Fresh spinach leaves. For Mr. Snuggles.")
		await C.player.say("Deer need proper nutrition too.")

	if not room.state.breakfast_done:
		await E.queue([
			"Mr. Snuggles eyes the spinach hopefully",
			"Pig: We'll eat in the morning. Patience, buddy."
		])


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["spinach_leaves"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The spinach is fine as it is.")


#endregion
