@tool
extends PopochiuHotspot
## Beach hotspot - The sandy beach at Brazil's edge

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Sand. Lots of sand.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to bury that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The beach stretches as far as I can see!")
	await C.player.say("Perfect for building sand castles... or launching rafts!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I dig in the sand with my hands.")
	await C.player.say("No treasure. Just more sand.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello beach! We're going to sail away from here!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up an entire beach.")
	await C.player.say("...Or CAN I?")
	await C.player.say("No. No I can't.")


#endregion
