@tool
extends PopochiuInventoryItem
## Sap Bark - Tree bark coated in toxic sap. Tank calls it "flavor sauce bark".
## Only dangerous if Tank KNOWS the sap is toxic (Ignorance mechanic)!

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("Flavor sauce bark!")
	await C.player.say("Nature's syrup!")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("DELICIOUS BARK WITH NATURAL SYRUP!")
		await C.player.say("This will make any meal better!")
	else:
		await C.player.say("This bark is coated in toxicwood sap...")
		await C.player.say("It causes severe stomach cramps if ingested.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The flavor sauce stays on the bark!")


#endregion
