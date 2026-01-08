extends PopochiuInventoryItem
## Helmet - provides protection during re-entry/crash prep
## Obtained from police car during BRAWN solution in Road of Monsters room.

const Data := preload('inventory_item_helmet_state.gd')

var state: Data = load("res://game/inventory_items/helmet/inventory_item_helmet.tres")


#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.say("A protective helmet! This will keep my head safe.")


func _on_right_click() -> void:
	await C.player.say("Strong, sturdy. Good for impacts.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == "DonutBox":
		await C.player.say("I'm not storing donuts in my helmet.")
	else:
		await C.player.say("I don't think that goes with the helmet.")


func _on_added_to_inventory() -> void:
	super()
	await C.player.say("Safety first!")


#endregion
