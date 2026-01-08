@tool
extends PopochiuInventoryItem
## Shell Whistle - Conch shell that can be blown. Useful in fog.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("A shell whistle!")
	await C.player.say("*HOOONK*")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("MY BATTLE HORN!")
		await C.player.say("When I blow it, enemies TREMBLE!")
	else:
		await C.player.say("A conch shell that makes a loud sound.")
		await C.player.say("Could be useful for signaling in low visibility.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I should save my breath for emergencies!")


#endregion
