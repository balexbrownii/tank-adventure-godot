@tool
extends PopochiuHotspot
## Case File Overlay hotspot - Information display

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Some kind of information display.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("The display doesn't need that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A case file overlay!")
	await C.player.say("It shows my mission status: GET BACK TO EARTH!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I check the display for useful info.")
	await C.player.say("Optimal reentry angle: 'JUST GO'")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Any advice, display?")
	await C.player.say("It flashes: 'AIM FOR EARTH'")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a holographic display!")
	await C.player.say("My hand goes right through it!")


#endregion
