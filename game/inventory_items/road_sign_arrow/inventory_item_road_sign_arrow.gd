@tool
extends PopochiuInventoryItem
## Road Sign Arrow - Removed from a road sign. Can be used as a lever.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("A metal arrow from a road sign.")
	await C.player.say("Pointy on one end, sturdy on the other.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("The DIRECTION POINTER! It guided me to victory!")
	else:
		await C.player.say("A road sign arrow. Good leverage potential.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't think I can pry that with this arrow.")


#endregion
