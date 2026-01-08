@tool
extends PopochiuHotspot
## Mini donuts hotspot - Food supplies that need to be protected

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.raccoon_stole_donuts:
		await C.player.say("The donuts... are gone.")
		await C.player.say("CURSE YOU, RACCOON!")
		return

	if room.state.breakfast_done:
		await C.player.say("We already had some for breakfast.")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("PRECIOUS TREASURE!")
		await C.player.say("I must protect these with my LIFE!")
	else:
		await C.player.say("Mini donuts. Should probably secure them overnight.")
		await C.player.say("Don't want any animals getting into them.")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["mini_donuts"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I should eat the donuts, not put things on them!")


#endregion
