@tool
extends PopochiuHotspot
## Vending Machine hotspot - Snacks and drinks

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A vending machine full of snacks.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("The vending machine doesn't accept that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A vending machine!")
	await C.player.say("Chips, candy, and... MINI DONUTS!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I put in some coins...")
	await C.player.say("CLUNK! A snack drops out!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello vending machine! Give me donuts!")
	await C.player.say("It hums invitingly.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to shake the machine!")
	await C.player.say("Nothing extra falls out. Worth a try!")


#endregion
