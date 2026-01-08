@tool
extends PopochiuHotspot
## Cargo Straps hotspot - For securing cargo during flight

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Heavy-duty cargo straps.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to strap that down.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Cargo straps for keeping things secure!")
	await C.player.say("The plane is shaking a lot...")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I strap myself to the cargo!")
	await C.player.say("Click! Now I won't fly around!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hold tight, straps! Things are getting bumpy!")
	await C.player.say("They seem sturdy enough.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't take the cargo straps.")
	await C.player.say("They're securing important stuff!")


#endregion
