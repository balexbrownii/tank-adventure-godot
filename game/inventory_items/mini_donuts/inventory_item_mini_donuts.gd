@tool
extends PopochiuInventoryItem
## Mini Donuts - Food/morale item from Pig's supplies.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Mini donuts! Like regular donuts but TINY!")
	await C.player.say("They're adorable AND delicious!")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("BABY DONUTS! I must protect them!")
		await C.player.say("Or... eat them. One of those.")
	else:
		await C.player.say("A small bag of mini donuts. Good for snacking or bribing.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to waste my precious mini donuts!")


#endregion
