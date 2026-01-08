@tool
extends PopochiuHotspot
## Hotspot: Sap Smear (FLAVOR SAUCE / Tree Sap suspicious)
## Toxic sap from a toxicwood tree - causes severe stomach cramps
## Only dangerous if Tank KNOWS it's poisonous

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	if room.state.took_chalk:
		await C.Tank.say("I already got what I needed from here.")
		return

	await E.queue([
		"Tank: *touches the sap*",
		"Tank: Ooh, sticky! This would be good on food!",
	])


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["sap_smear"])
	await C.Tank.say(text)

	# Reality mode reveals the danger
	if TankVision.is_reality_mode:
		await E.queue([
			"*The sap has an acrid smell*",
			"*This is definitely not maple syrup...*",
		])


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"LeafWrap":
			await E.queue([
				"Tank: *smears sap on leaves*",
				"Tank: Now it's a FLAVOR wrap!",
			])
			# Add sap bark to inventory
			I.SapBark.add()
			room.state.took_chalk = true  # Prevent re-doing
		_:
			await C.Tank.say("I don't think that needs flavor sauce.")


#region Public ####################################################################################
func on_look_at() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await _on_look()


func on_use() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await _on_interact()


func on_talk_to() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("Hey there, sticky stuff!")
	await C.player.say("You'd taste great on food!")


func on_pick_up() -> void:
	await C.player.walk_to_clicked()
	await C.player.face_clicked()
	await C.player.say("I need something to collect it with.")
	await C.player.say("Can't just grab handfuls of sticky sap!")


#endregion
