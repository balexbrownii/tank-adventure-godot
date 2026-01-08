@tool
extends PopochiuInventoryItem
## Motorcycle Key - Found near the landing site. Starts the motorcycle.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("A key-ish thing for the metal horse!")
	await C.player.say("It's got that jangling quality.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("The TAMING ARTIFACT! For the metal horse!")
	else:
		await C.player.say("A motorcycle key. Should start the bike.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The key doesn't combine with that.")


#endregion
