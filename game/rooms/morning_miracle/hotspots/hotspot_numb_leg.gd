@tool
extends PopochiuHotspot
## Numb Leg hotspot - Tank's leg that fell asleep

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("My leg! It feels so weird!")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't think that will help my leg.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("MY LEG! I CAN'T FEEL IT!")
	await C.player.say("Wait... it's still attached. Just numb.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to stand up!")
	await C.player.say("TINGLES! So many tingles!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("LEG! ARE YOU OKAY?!")
	await C.player.say("The leg doesn't answer. Very concerning!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to lift my leg.")
	await C.player.say("It moves! The leg is back!")


#endregion
