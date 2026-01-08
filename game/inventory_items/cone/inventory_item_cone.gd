extends PopochiuInventoryItem
## Traffic Cone - "Warning Totems"
## Used to redirect traffic for BRAINS solution.

const Data := preload('inventory_item_cone_state.gd')

var state: Data = load("res://game/inventory_items/cone/inventory_item_cone.tres")


#region Virtual ####################################################################################
func _on_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("A warning totem! The survivors left these to mark danger!")
	else:
		await C.player.say("Orange traffic cone. Good for redirecting traffic.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("Ancient wisdom in triangular form.")
	else:
		await C.player.say("Standard reflective safety cone.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == "RockChalk":
		await C.player.say("I could mark the cone to make it more official looking!")
	else:
		await C.player.say("I don't think I need to combine those.")


func _on_added_to_inventory() -> void:
	super()
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("I claim this totem of warning!")
	else:
		await C.player.say("Got the traffic cone.")


#endregion
