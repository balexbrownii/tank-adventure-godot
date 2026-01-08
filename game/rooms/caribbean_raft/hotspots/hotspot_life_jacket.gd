@tool
extends PopochiuHotspot
## Life Jacket hotspot - Mr. Snuggles' safety gear

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Mr. Snuggles' life jacket. Safety first!")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("The life jacket doesn't need that.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Pig made this life jacket for Mr. Snuggles!")
	await C.player.say("It's made from coconut shells and cloth. Very clever!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I check the straps. Nice and tight!")
	await C.player.say("Mr. Snuggles is safe if we capsize!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Don't worry life jacket, you're doing great!")
	await C.player.say("Mr. Snuggles nods calmly.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't take it off Mr. Snuggles.")
	await C.player.say("He needs it more than I do!")


#endregion
