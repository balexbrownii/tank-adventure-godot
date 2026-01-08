@tool
extends PopochiuInventoryItem
## Plush Stuck - A promotional plushie stuck to Tank after crashing into a pile.
## Cosmetic fail-forward item.

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("There's a plushie stuck to my back.")
	await C.player.say("It's... actually kind of comforting.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("My NEW FRIEND! It's been with me since the crash!")
		await C.player.say("I shall call it... CRASHY!")
	else:
		await C.player.say("A promotional plushie from the gas station.")
		await C.player.say("It's really stuck on there.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't use my plush friend on that!")


#endregion
