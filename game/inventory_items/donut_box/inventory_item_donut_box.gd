extends PopochiuInventoryItem
## Donut Box - sacred rings of power / delicious snacks
## Can be used as bribe, morale boost, or donut compass in space.
## Obtained during BRAINS solution in Road of Monsters room.

const Data := preload('inventory_item_donut_box_state.gd')

var state: Data = load("res://game/inventory_items/donut_box/inventory_item_donut_box.tres")


#region Virtual ####################################################################################
func _on_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("The sacred rings! They glow with inner power!")
	else:
		await C.player.say("A box of fresh donuts. They smell amazing.")


func _on_right_click() -> void:
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("I can feel their energy calling to me.")
	else:
		await C.player.say("Glazed, chocolate, and sprinkles. Classic selection.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == "Helmet":
		await C.player.say("I'm not storing donuts in a helmet.")
	else:
		await C.player.say("The sacred rings must not be combined with lesser objects.")


func _on_added_to_inventory() -> void:
	super()
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("The sacred rings are mine!")
	else:
		await C.player.say("Score! Free donuts!")


#endregion
