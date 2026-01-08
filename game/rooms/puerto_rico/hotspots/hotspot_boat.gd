@tool
extends PopochiuHotspot
## Boat hotspot - Transportation to Florida

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A nice-looking boat.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to put that on the boat.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A boat! Perfect for getting to Florida!")
	await C.player.say("Pig says we should... borrow it.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I check if the boat has keys.")
	await C.player.say("Hmm, we might need to hotwire it...")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello boat! Will you take us to Florida?")
	await C.player.say("It bobs invitingly in the water.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I could carry this boat...")
	await C.player.say("But it's easier to just sail it!")


#endregion
