@tool
extends PopochiuInventoryItem
## Hollow Log Bark - A piece of bark from the hollow log.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("A piece of bark!")
	await C.player.say("From the nature tunnel!")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("TREE SKIN!")
		await C.player.say("The tree shed its skin for me!")
	else:
		await C.player.say("A curved piece of bark.")
		await C.player.say("Could use it as a scoop or container.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The bark is useful on its own.")


#endregion
