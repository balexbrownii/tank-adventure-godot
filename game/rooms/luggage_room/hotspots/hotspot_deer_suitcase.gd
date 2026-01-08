@tool
extends PopochiuHotspot

## Deer Suitcase hotspot - GRAY BOX WITH DEER SMELL / Gray Suitcase (Mr. Snuggles)

@onready var room: Node = get_parent().get_parent()


func _on_click() -> void:
	await C.Tank.walk_to_clicked()
	await C.Tank.face_clicked()

	if not room.state.party_linked:
		await _try_link_party()
	else:
		await C.Tank.say("Mr. Snuggles is safe in there!")
		await E.queue([
			"*Reassuring tap from inside the suitcase*",
		])


func _try_link_party() -> void:
	if not room.state.found_texas_suitcase:
		await C.Tank.say("I need to figure out which suitcase to get in first!")
		return

	await C.Tank.say("Mr. Snuggles! We need to stay together!")

	# Start the keep party together dialog
	await D.KeepPartyTogether.start()


func _on_right_click() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["deer_suitcase"])
	await C.Tank.say(inspect_text)


func _on_look() -> void:
	var inspect_text: String = TankVision.get_inspect_text(room.vision_data["deer_suitcase"])
	await C.Tank.say(inspect_text)

	await E.queue([
		"*tap tap tap*",
		"A gentle tapping sound comes from inside.",
	])


func _on_interact() -> void:
	await _on_click()


func _on_item_used(item: PopochiuInventoryItem) -> void:
	# Link with rope
	if item.script_name == "Rope" or item.script_name == "MoistRope":
		if room.state.found_texas_suitcase and not room.state.party_linked:
			await room.execute_brains_rope_link()
		else:
			await C.Tank.say("Already linked!")


func get_description() -> String:
	return TankVision.get_hover_text(room.vision_data["deer_suitcase"])
