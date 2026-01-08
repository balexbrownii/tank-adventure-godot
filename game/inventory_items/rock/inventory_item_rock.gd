@tool
extends PopochiuInventoryItem
## Rock - A good throwing rock.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("A nice smooth rock!")
	await C.player.say("Perfect for throwing at things.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("MY PET ROCK!")
		await C.player.say("I shall call you... Rocky!")
	else:
		await C.player.say("A fist-sized rock. Good for throwing.")
		await C.player.say("Or just general rock needs.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I shouldn't combine Rocky with anything.")


#endregion
