@tool
extends PopochiuHotspot
## Supplies Pouch hotspot - Pig's travel supplies. Can't access until recruited.

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom

	if room.state.pig_joined:
		await C.player.say("Pig already shared the supplies with us!")
		return

	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("TREASURE BAG! I want to see what's inside!")
		await C.player.say("But the angry bacon is guarding it...")
	else:
		await C.player.say("The pig's supply pouch. Looks well-organized.")
		await C.player.say("I should probably ask before touching it.")


func _on_right_click() -> void:
	var room = get_parent().get_parent().get_parent() as PopochiuRoom
	var inspect = TankVision.get_inspect_text(room.vision_data["supplies_pouch"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I shouldn't mess with someone else's supplies.")


#endregion
