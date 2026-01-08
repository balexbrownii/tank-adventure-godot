@tool
extends PopochiuHotspot
## Deer hotspot - Meeting Mr. Snuggles

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A calm-looking deer.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("Mr. Snuggles politely declines.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A beautiful deer! So calm and peaceful!")
	await C.player.say("Pig calls him Mr. Snuggles. Perfect name!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I pet Mr. Snuggles gently.")
	await C.player.say("He nuzzles my hand. So soft!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello Mr. Snuggles! You're very handsome!")
	await C.player.say("He blinks calmly. Very zen.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to lift Mr. Snuggles.")
	await C.player.say("He's too big! And he looks offended!")


#endregion
