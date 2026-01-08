@tool
extends PopochiuHotspot
## Moonlight Gap hotspot - Opening in the canopy

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A gap in the trees. Moonlight shines through.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I can't use that on moonlight.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Moonlight streams through the canopy!")
	await C.player.say("It's beautiful... and helps me see!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The sun is rising! Morning already!")
	await C.player.say("Time to climb out and continue!")
	E.goto_room("MorningMiracle")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello moonlight! Thanks for guiding me!")
	await C.player.say("The light shimmers peacefully.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to catch moonlight in my hands.")
	await C.player.say("It's pretty but not pickable.")


#endregion
