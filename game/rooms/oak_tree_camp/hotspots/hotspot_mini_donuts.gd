@tool
extends PopochiuHotspot
## Mini Donuts hotspot - Tank's favorite snack

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("DONUTS! My favorite!")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("I don't want to ruin the donuts!")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("MINI DONUTS!")
	await C.player.say("The most perfect food in existence!")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I eat a mini donut!")
	await C.player.say("Mmmm! SO GOOD!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello donuts! I love you!")
	await C.player.say("They smell delicious!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I carefully pick up the donuts.")
	await C.player.say("Must protect these precious treasures!")


#endregion
