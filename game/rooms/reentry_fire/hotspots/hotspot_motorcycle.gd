@tool
extends PopochiuHotspot
## Motorcycle hotspot - New ride after space landing

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A motorcycle! Conveniently abandoned!")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The motorcycle doesn't need that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A motorcycle! Someone left it here!")
	await C.player.say("Perfect for continuing my journey!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I hop on the motorcycle!")
	await C.player.say("VROOOOM! Time to ride!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello motorcycle! Will you be my new friend?")
	await C.player.say("The engine purrs welcomingly.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I lift the motorcycle above my head!")
	await C.player.say("POWER! ...Now I'll put it down.")


#endregion
