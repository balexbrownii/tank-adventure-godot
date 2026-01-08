@tool
extends PopochiuHotspot
## Deer Suitcase hotspot - Where Mr. Snuggles will hide

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A really big suitcase. Deer-sized, actually.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't need to put that in the deer suitcase.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("This suitcase is HUGE!")
	await C.player.say("Big enough for Mr. Snuggles to hide in!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I open the giant suitcase.")
	await C.player.say("Empty! Perfect for a deer!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello big suitcase! Ready for a deer passenger?")
	await C.player.say("It seems roomy and willing.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I lift the giant suitcase.")
	await C.player.say("Heavy even when empty! Must be fancy!")


#endregion
