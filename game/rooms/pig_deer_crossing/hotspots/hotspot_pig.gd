@tool
extends PopochiuHotspot
## Pig hotspot - Meeting Pig for the first time

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A pig wearing tight workout pants!")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("Pig doesn't want that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("It's a pig! A talking pig!")
	await C.player.say("He's wearing really tight workout pants!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I give Pig a friendly pat!")
	await C.player.say("He seems annoyed but tolerant.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello, Mr. Pig! Nice pants!")
	await C.player.say("'Whudyue tink yer doin?!' he responds.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to pick up Pig.")
	await C.player.say("'PUT ME DOWN!' he shouts. Okay, okay!")


#endregion
