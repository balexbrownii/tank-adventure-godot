@tool
extends PopochiuHotspot
## Spinach Leaves hotspot - Mr. Snuggles' food

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Spinach. Mr. Snuggles' favorite.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The spinach doesn't need that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Fresh spinach leaves for Mr. Snuggles!")
	await C.player.say("Deer love this stuff!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I offer spinach to Mr. Snuggles.")
	await C.player.say("He munches happily. Good deer!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello spinach! You're deer food!")
	await C.player.say("The spinach rustles leafily.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab some spinach leaves.")
	await C.player.say("Snack time for Mr. Snuggles later!")


#endregion
