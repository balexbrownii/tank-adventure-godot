@tool
extends PopochiuInventoryItem
## Raft Patch - Spare tarp for emergency raft repairs.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Extra tarp!")
	await C.player.say("For emergency repairs!")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("EMERGENCY ARMOR PATCH!")
		await C.player.say("In case the raft gets BATTLE DAMAGE!")
	else:
		await C.player.say("A piece of waterproof tarp.")
		await C.player.say("Could patch a hole in the raft if needed.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("Save the patch for an actual emergency!")


#endregion
