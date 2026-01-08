@tool
extends PopochiuInventoryItem
## Backpack - Tank's worn travel backpack with supplies.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("My trusty backpack!")
	await C.player.say("Full of useful things... probably.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("TREASURE SACK!")
		await C.player.say("Every adventurer needs a sack for treasures!")
	else:
		await C.player.say("A worn backpack. Seen better days.")
		await C.player.say("But still functional.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't combine that with my backpack.")


#endregion
