@tool
extends PopochiuHotspot
## Campfire hotspot - Tank's small campfire

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("It's a warm, cozy fire.")


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A campfire. Good for warmth and cooking bacon.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I shouldn't put that in the fire.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("WARM FRIEND! The fire keeps the monsters away!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I warm my hands by the fire. Toasty!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello fire! You're doing a great job!")
	await C.player.say("The fire crackles in response.")


#endregion
