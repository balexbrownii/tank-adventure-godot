@tool
extends PopochiuHotspot
## Hotspot: Waterline (THE GATEWAY TO CANADA / Water's Edge)
## Where the raft launches - blocked until life jacket is ready

@onready var room: Node = get_parent().get_parent()


func _on_interact() -> void:
	if not room.state.jacket_crafted:
		# Trigger life jacket puzzle
		room.trigger_life_jacket_puzzle()
		return

	if room.state.raft_launched:
		await C.Tank.say("We already launched!")
		return

	# Ready to launch
	room.launch_raft()


func _on_look() -> void:
	var text: String = TankVision.get_inspect_text(room.vision_data["waterline"])
	await C.Tank.say(text)

	if not room.state.jacket_crafted:
		await E.queue([
			"*Mr. Snuggles looks at the water nervously*",
			"*He needs a life jacket before we can go*",
		])
	else:
		await E.queue([
			"*Mr. Snuggles floats confidently in his life jacket*",
			"*Ready to launch!*",
		])


func _on_item_used(item: PopochiuInventoryItem) -> void:
	match item.script_name:
		"Oar":
			if room.state.jacket_crafted:
				await C.Tank.say("Yes! Let's LAUNCH!")
				room.launch_raft()
			else:
				await C.Tank.say("We need to make Mr. Snuggles a life jacket first!")
		"LifeJacket", "LifeJacketBulky":
			await E.queue([
				"Tank: *puts life jacket on Mr. Snuggles*",
				"Mr. Snuggles: *adjusts to the fit*",
			])
		_:
			await C.Tank.say("That won't help us launch.")
