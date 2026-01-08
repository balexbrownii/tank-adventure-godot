@tool
extends PopochiuHotspot
## Motorcycle Parked hotspot - Tank's ride

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("My motorcycle! Still warm from the ride!")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The motorcycle doesn't need that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("My beautiful motorcycle!")
	await C.player.say("I got it after... that whole space incident.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I rev the engine!")
	await C.player.say("VROOOOM! Still works great!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Good motorcycle! You're my metal horse!")
	await C.player.say("It rumbles proudly.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I lift the motorcycle above my head!")
	await C.player.say("...Why did I do that? I put it back down.")


#endregion
