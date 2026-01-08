@tool
extends PopochiuHotspot
## Donut Box hotspot - Glorious donuts!

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("DONUTS! A whole box of them!")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to ruin the donuts!")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("A BOX OF DONUTS!")
	await C.player.say("The most beautiful thing I've ever seen!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I eat ALL THE DONUTS!")
	await C.player.say("NOM NOM NOM! DELICIOUS!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello donuts! I LOVE YOU!")
	await C.player.say("They smell like heaven!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I grab the donut box carefully!")
	await C.player.say("Must protect these precious circles!")


#endregion
