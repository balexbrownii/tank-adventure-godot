@tool
extends PopochiuHotspot
## Starfield hotspot - Background stars that provide comedy and atmosphere.

#region Virtual ####################################################################################
func _on_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("Are all those tiny suns cheering for me?")
		await C.player.say("YES! GO TANK! SWIM TANK! SWIM!")
		await C.player.say("...I'm imagining their cheers.")
	else:
		await C.player.say("Stars. If only I knew which constellation points home...")
		await C.player.say("Is that the Big Donut? Little Donut?")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["starfield"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't reach the stars from here.")
	await C.player.say("...YET.")


#endregion
