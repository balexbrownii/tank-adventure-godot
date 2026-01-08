@tool
extends PopochiuHotspot
## Vine Rope hotspot - Natural rope for lashing the raft

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Strong jungle vines.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("The vines don't need that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Thick jungle vines! Perfect for tying things together!")
	await C.player.say("Pig called this 'natural rope'. Smart pig!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I test the vine's strength by trying to rip it.")
	await C.player.say("It holds! This pig knows what he's talking about!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Thank you for being strong, little vine!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I coil up the vines. Ready for raft-making!")


#endregion
