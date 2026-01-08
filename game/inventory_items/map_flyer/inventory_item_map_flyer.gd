extends PopochiuInventoryItem
## Map Flyer - Gas Station Map Flyer showing local area
## Useful for navigation puzzles later.
## Obtained during BIZARRE solution in Road of Monsters room.

const Data := preload('inventory_item_map_flyer_state.gd')

var state: Data = load("res://game/inventory_items/map_flyer/inventory_item_map_flyer.tres")


#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("A map of the local area. Shows roads, landmarks...")


func _on_right_click() -> void:
	await C.player.say("'PitStop Express - Your Journey Starts Here!'")
	await C.player.say("There's a small map printed on the back.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to combine this with anything.")


func _on_added_to_inventory() -> void:
	super()
	await C.player.say("This might help with navigation later.")


#endregion
