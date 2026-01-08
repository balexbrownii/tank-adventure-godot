@tool
extends PopochiuHotspot
## Maintenance Door hotspot - Back way into the airport

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("A door marked 'Staff Only'.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("Hmm, that won't help open this door.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A maintenance door!")
	await C.player.say("Pig says this might be our way in!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I try the handle...")
	await C.player.say("*CRACK* Oops, I broke the lock.")
	await C.player.say("Well, it's open now!")
	E.goto_room("LuggageRoom")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello door! Will you let us in?")
	await C.player.say("The door remains stubbornly closed.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up a door.")
	await C.player.say("Well, I could rip it off, but that's noisy.")


#endregion
