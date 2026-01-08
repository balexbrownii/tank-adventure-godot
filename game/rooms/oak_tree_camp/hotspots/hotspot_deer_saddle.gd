@tool
extends PopochiuHotspot
## Deer Saddle hotspot - Where Pig rides Mr. Snuggles

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A saddle for Mr. Snuggles.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to attach that to the saddle.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Pig's riding saddle for Mr. Snuggles!")
	await C.player.say("It has special clips for Pig's tight workout pants!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I adjust the saddle straps.")
	await C.player.say("Nice and snug! Ready for Pig!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello saddle! Take care of Pig!")
	await C.player.say("It's well-maintained and comfortable-looking.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't take the saddle off Mr. Snuggles.")
	await C.player.say("He seems to like wearing it!")


#endregion
