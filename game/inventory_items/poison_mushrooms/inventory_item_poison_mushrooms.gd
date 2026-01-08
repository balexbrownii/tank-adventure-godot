@tool
extends PopochiuInventoryItem
## Poison Mushrooms - Tank thinks they're delicious adventure snacks.
## Only dangerous if Tank KNOWS they're poisonous (Ignorance mechanic)!

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Adventure snacks!")
	await C.player.say("Nature provides!")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("DELICIOUS FOREST TREATS!")
		await C.player.say("Mother Nature's gift to warriors!")
	else:
		await C.player.say("These mushrooms have unusual markings...")
		await C.player.say("They match the poisonous variety from survival guides.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to mix these with anything else.")


#endregion
