@tool
extends PopochiuHotspot
## Waterline hotspot - Where the ocean meets the beach

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Where the water meets the sand.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to throw that in the ocean.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The ocean! It's SO BIG!")
	await C.player.say("Puerto Rico is out there somewhere!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I splash in the water!")
	await C.player.say("Hehe! Salty!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello ocean! We're going to sail across you!")
	await C.player.say("The waves seem... indifferent.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to pick up the ocean.")
	await C.player.say("It just runs through my fingers.")


#endregion
