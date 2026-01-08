@tool
extends PopochiuHotspot
## Wanted poster hotspot - Tank's wanted poster nailed to a tree

#region Virtual ####################################################################################
func _on_click() -> void:
	var room = R.WantedCamp
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("IMPORTANT PAPER! Someone drew a picture of me!")
		await C.player.say("I look GREAT! So muscular!")
	else:
		await C.player.say("A wanted poster... with my face on it.")
		await C.player.say("Large reward. That's a lot of zeroes.")
		room.state.poster_examined_reality = true


func _on_right_click() -> void:
	var room = R.WantedCamp
	var inspect = TankVision.get_inspect_text(room.vision_data["wanted_poster"])
	await C.player.say(inspect)


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	match _item.script_name:
		"Machete":
			await C.player.say("I could cut a piece of this...")
			await _take_poster_scrap()
		_:
			await C.player.say("That won't help with the poster.")


#endregion

#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	var room = R.WantedCamp
	if TankVision.current_mode == TankVision.VisionMode.TANK:
		await C.player.say("IMPORTANT PAPER! Someone drew a picture of me!")
		await C.player.say("I look GREAT! So muscular!")
	else:
		await C.player.say("A wanted poster... with my face on it.")
		await C.player.say("Large reward. That's a lot of zeroes.")
		room.state.poster_examined_reality = true


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I can't use the poster like that.")


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hello, handsome picture of me!")
	await C.player.say("...")
	await C.player.say("It doesn't respond. Rude.")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("It's nailed to the tree pretty firmly.")
	await C.player.say("I could cut a piece with something sharp though...")


#endregion

#region Private ####################################################################################
func _take_poster_scrap() -> void:
	var room = R.WantedCamp
	if room.state.poster_scrap_taken:
		await C.player.say("I already got a piece.")
		return

	await E.queue([
		"Tank carefully cuts a corner of the poster",
		"Tank: Evidence! Of my greatness!"
	])

	I.PosterScrap.add_to_inventory()
	room.state.poster_scrap_taken = true


#endregion
