@tool
extends PopochiuHotspot
## Donut Scent Trail hotspot - The smell of donuts guides the way

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("I smell... donuts? IN SPACE?!")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("That won't help me follow the smell!")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Is that... a trail of donut scent?")
	await C.player.say("It leads back toward Earth!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I follow the donut smell!")
	await C.player.say("It's guiding me home!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Thank you, magical donut smell!")
	await C.player.say("I will follow you anywhere!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try to catch the smell!")
	await C.player.say("It's... not a physical thing.")


#endregion
