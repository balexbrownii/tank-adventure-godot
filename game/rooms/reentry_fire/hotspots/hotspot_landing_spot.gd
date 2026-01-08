@tool
extends PopochiuHotspot
## Landing Spot hotspot - Where Tank landed from space

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A crater in the ground. Did I make that?")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to put that in the crater.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("The spot where I landed!")
	await C.player.say("Still smoking from the impact...")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I touch the ground. Still warm!")
	await C.player.say("Reentry was HOT!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Thank you, ground! Thanks for catching me!")
	await C.player.say("The crater smolders appreciatively.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab some charred dirt.")
	await C.player.say("A souvenir from my space adventure!")


#endregion
