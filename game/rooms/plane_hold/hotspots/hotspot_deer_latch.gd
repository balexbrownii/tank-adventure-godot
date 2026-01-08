@tool
extends PopochiuHotspot
## Deer Latch hotspot - Keeping Mr. Snuggles secure

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("The latch on Mr. Snuggles' container.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to use that on the latch.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The latch keeping Mr. Snuggles safe!")
	await C.player.say("Pig made sure it's extra secure!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I check the latch.")
	await C.player.say("Still secure! Mr. Snuggles is safe!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Stay strong, latch! Protect the deer!")
	await C.player.say("It clicks reassuringly.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I shouldn't open this during the flight!")
	await C.player.say("Mr. Snuggles needs to stay secure!")


#endregion
