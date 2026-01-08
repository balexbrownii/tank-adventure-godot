@tool
extends PopochiuHotspot
## Backpack hotspot - Tank's trusty backpack

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("My backpack. Full of useful stuff!")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I could put that in my backpack, but why?")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("My trusty backpack!")
	await C.player.say("Contains snacks, supplies, and hopefully no spiders.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I rummage through the backpack.")
	await C.player.say("Some granola bars and a water bottle. Good!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hey backpack! You're my favorite!")
	await C.player.say("It holds all my important stuff!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I pick up my backpack and swing it on.")
	await C.player.say("Ready for adventure!")


#endregion
