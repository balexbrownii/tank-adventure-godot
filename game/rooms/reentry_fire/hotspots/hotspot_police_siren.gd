@tool
extends PopochiuHotspot
## Police Siren hotspot - Cops are coming!

#region Virtual ####################################################################################
func _on_click() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()


func _on_right_click() -> void:
	await C.player.face_clicked()
	await C.player.say("Police sirens in the distance!")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	await C.player.say("That won't stop the police!")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Flashing lights! Police cars!")
	await C.player.say("They're probably here about the crater...")


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I wave at the police!")
	await C.player.say("Wait, I'm a wanted criminal! Bad idea!")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("HELLO OFFICERS! Nice day!")
	await C.player.say("They're shouting something about 'meteor crime'...")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't pick up police sirens!")
	await C.player.say("They're attached to police cars!")


#endregion
