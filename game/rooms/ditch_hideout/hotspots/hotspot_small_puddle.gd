@tool
extends PopochiuHotspot
## Small Puddle hotspot - Water collected in the ditch

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A small puddle of water.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to drop that in the puddle.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A puddle from last night's rain!")
	await C.player.say("I can see my reflection... Looking good, Tank!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I splash in the puddle!")
	await C.player.say("SPLISH SPLASH! Refreshing!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello puddle! Hello reflection of me!")
	await C.player.say("Reflection-Tank waves back. Friendly!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I cup some water in my hands.")
	await C.player.say("Cool and refreshing!")


#endregion
