@tool
extends PopochiuHotspot
## Luggage Carts hotspot - For hiding in

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Luggage carts for moving bags around.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to put that on the cart.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Luggage carts full of suitcases!")
	await C.player.say("Pig has an idea about these...")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I push the cart around.")
	await C.player.say("Wheee! This is fun!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello cart! Hello suitcases!")
	await C.player.say("They seem ready for adventure!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab a suitcase from the cart.")
	await C.player.say("Ooh, this one's empty! Perfect!")


#endregion
