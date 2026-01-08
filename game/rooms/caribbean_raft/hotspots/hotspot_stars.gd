@tool
extends PopochiuHotspot
## Stars hotspot - The starfield above

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Stars. Millions of them.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("Stars are too far away for that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("So many stars! They're beautiful!")
	await C.player.say("Pig says sailors used these to find their way.")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to connect the dots to make pictures.")
	await C.player.say("I see a... donut? No wait, that's just wishful thinking.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello stars! Are any of you planets?")
	await C.player.say("The stars twinkle mysteriously.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to catch a star!")
	await C.player.say("My hand closes on nothing. Stars are tricky.")


#endregion
