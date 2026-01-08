@tool
extends PopochiuHotspot
## Road hotspot - Background element showing the near-accident.

#region Virtual ####################################################################################
func _on_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("The monster path! I stopped just in time!")
		await C.player.say("The fluffy horse and angry bacon were in danger!")
	else:
		await C.player.say("The road. My skid marks are pretty impressive.")
		await C.player.say("I really need to learn to control that motorcycle better.")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["road"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to put anything on the road.")


#endregion
