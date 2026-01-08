@tool
extends PopochiuHotspot
## Deer saddle hotspot - Mr. Snuggles' riding equipment (Bizarre solution trigger)

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.camp_secured:
		await C.player.say("Mr. Snuggles is resting. His saddle is secure.")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("The fluffy horse seat!")
		await C.player.say("Mr. Snuggles carries Pig in STYLE!")
	else:
		await C.player.say("Mr. Snuggles' saddle. Pig maintains it carefully.")
		await C.player.say("The strap looks much better now that I fixed it.")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["deer_saddle"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.camp_secured:
		await C.player.say("The saddle is fine.")
		return

	await C.player.say("Mr. Snuggles doesn't need that on his saddle.")


#endregion
