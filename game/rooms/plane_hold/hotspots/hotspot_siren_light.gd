@tool
extends PopochiuHotspot
## Siren Light hotspot - Emergency light in the cargo hold

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A flashing emergency light.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't use that on the light.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The emergency light is flashing!")
	await C.player.say("That... that's probably not good.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to turn off the light.")
	await C.player.say("It won't stop flashing. Uh oh.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("What are you trying to tell me, light?")
	await C.player.say("It just keeps flashing. Urgently.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't take the emergency light.")
	await C.player.say("It's bolted to the wall!")


#endregion
