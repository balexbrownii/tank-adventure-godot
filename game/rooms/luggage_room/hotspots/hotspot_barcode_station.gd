@tool
extends PopochiuHotspot
## Barcode Station hotspot - Scanning station for bags

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Computers that scan luggage barcodes.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("The scanner doesn't know what to do with that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A barcode scanning station!")
	await C.player.say("Beep beep! It reads where each bag goes!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I wave my hand under the scanner.")
	await C.player.say("BEEP! ERROR! I'm not a suitcase!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello scanner! Beep beep?")
	await C.player.say("BEEP! It seems to acknowledge me!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't take the scanner.")
	await C.player.say("It's bolted to the station.")


#endregion
