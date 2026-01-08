@tool
extends PopochiuHotspot
## Cloth Scrap hotspot - Sailcloth material

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Torn cloth. Probably from a ship.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't think that goes with the cloth.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A big piece of torn cloth!")
	await C.player.say("Pig says we can use this as a sail!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I wave the cloth around!")
	await C.player.say("WHOOOOSH! Wind power!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello cloth! You're going to catch the wind for us!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab the cloth. It's big but light!")


#endregion
