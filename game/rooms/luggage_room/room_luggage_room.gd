@tool
extends PopochiuRoom
## Room 15 - Luggage Room: Suitcase Choice + Conveyor Ride
## Two-part puzzle: Find the Texas suitcase, keep the party together.

var state = preload("res://game/rooms/luggage_room/room_luggage_room.tres")

## Vision data for Tank/Reality label differences
## Luggage room = "ICE CAVE OF BOXES" vs actual luggage area
var vision_data: Dictionary = {
	"suitcase_pile": {
		"tank_hover": "BOX MOUNTAIN",
		"tank_inspect": "So many boxes! They look like sleeping animals!",
		"reality_hover": "Suitcase Pile",
		"reality_inspect": "Dozens of suitcases. Need to find one going to Texas."
	},
	"destination_tags": {
		"tank_hover": "MYSTERIOUS LABELS",
		"tank_inspect": "Little papers with scribbles! What do they mean?!",
		"reality_hover": "Destination Tags",
		"reality_inspect": "Airport routing tags. The text is scrambled - need to rotate or fold to read."
	},
	"conveyor_belt": {
		"tank_hover": "MOVING FLOOR",
		"tank_inspect": "The floor is alive! It wants to take us somewhere!",
		"reality_hover": "Conveyor Belt",
		"reality_inspect": "Baggage handling conveyor. Suitcases get sorted by destination."
	},
	"barcode_station": {
		"tank_hover": "BEEP MACHINE",
		"tank_inspect": "It goes BEEP! Maybe it's talking to me?",
		"reality_hover": "Barcode Scanner Station",
		"reality_inspect": "Automated scanner reads destination tags. Routes bags accordingly."
	},
	"deer_suitcase": {
		"tank_hover": "GRAY BOX WITH DEER SMELL",
		"tank_inspect": "I sense Mr. Snuggles in there! Or maybe it's just the deer air freshener...",
		"reality_hover": "Gray Suitcase (Mr. Snuggles)",
		"reality_inspect": "The suitcase Mr. Snuggles crawled into. Need to keep it close."
	},
	"zippers": {
		"tank_hover": "TEETH LINE",
		"tank_inspect": "Little teeth! Don't bite me!",
		"reality_hover": "Zipper Mechanism",
		"reality_inspect": "Standard suitcase zippers. Could use the pull to escape if needed."
	}
}


func _on_room_entered() -> void:
	set_process(true)

	# Set cold atmosphere
	if not state.visited:
		state.visited = true
		await _play_entry_sequence()


func _play_entry_sequence() -> void:
	"""Play the sequence when entering the luggage room."""
	await E.queue([
		"*The suitcase bumps along the conveyor belt*",
		"*THUNK* Tank and Pig tumble out into the cold luggage room.",
	])

	await C.Tank.say("Brrrr! This is an ICE CAVE!")

	if GameState.has_party_member("Pig"):
		await C.player.say("It's just a luggage room. And WHERE is Mr. Snuggles?!")

	await C.Tank.say("His box went a different way!")

	await E.queue([
		"They need to find the deer before their suitcases get separated.",
		"And they still need to make sure they end up in TEXAS...",
	])

	# Start the two-puzzle sequence
	if not state.found_texas_suitcase:
		await D.SuitcaseChoice.start()


#region Puzzle A: Find Texas Suitcase

func execute_brains_tag_puzzle() -> void:
	"""Brains solution 1: Rotate/fold tag text puzzle using WordManager."""
	state.found_texas_suitcase = true
	state.solution_tag = "text_puzzle"
	GameState.solve_puzzle("find_texas_suitcase", GameState.Approach.BRAINS)

	await E.queue([
		"*Tank squints at the scrambled tag*",
	])
	await C.Tank.say("The letters are all jumbled!")

	if GameState.has_party_member("Pig"):
		await C.player.say("Rotate it! The letters fold over each other!")

	# Use WordManager for the Device 6 style puzzle
	if WordManager:
		# Create sentence with scrambled letters that rearrange
		var sentence_id: String = WordManager.create_sentence(
			"tag_puzzle",
			"XASTE",
			["XASTE"]  # The word to drop/manipulate
		)
		# Player would interact with word puzzle UI to rearrange to "TEXAS"

	await E.queue([
		"*Tank tilts and rotates the tag*",
		"*X-A-S-T-E becomes... T-E-X-A-S!*",
	])
	await C.Tank.say("TEXAS! I cracked the code!")

	# Gain tag item
	I.DestinationTag.add()
	await I.DestinationTag.add_popup()


func execute_brains_craft_solution() -> void:
	"""Brains solution 2: Pig crafts/fixes tag with sticker sheet."""
	state.found_texas_suitcase = true
	state.solution_tag = "craft"
	GameState.solve_puzzle("find_texas_suitcase", GameState.Approach.BRAINS)

	await E.queue([
		"*Pig digs through his supplies*",
	])

	if GameState.has_party_member("Pig"):
		await C.player.say("I've got stickers here. Let me make us a proper tag.")

	await E.queue([
		"*Pig carefully applies letter stickers*",
		"*T... E... X... A... S*",
		"*A perfect destination tag*",
	])

	I.DestinationTag.add()
	I.StickerSheet.add()  # Leftovers
	await E.queue([
		"Pig: Here. Take the leftover stickers too.",
		"Pig: Might come in handy for... I dunno, labeling things.",
	])
	await I.DestinationTag.add_popup()
	await I.StickerSheet.add_popup()


func execute_brawn_tag_solution() -> void:
	"""Brawn solution: Rip tags off and reattach by force."""
	state.found_texas_suitcase = true
	state.solution_tag = "force"
	GameState.solve_puzzle("find_texas_suitcase", GameState.Approach.BRAWN)
	GameState.add_heat(1)  # Loud/destructive

	await C.Tank.say("I don't have time for puzzles!")
	await E.queue([
		"*RRRRIP*",
		"*Tank tears tags off multiple suitcases*",
	])

	if GameState.has_party_member("Pig"):
		await C.player.say("What are you DOING?!")

	await C.Tank.say("Redecorating!")
	await E.queue([
		"*Tank slaps a TEXAS tag onto their suitcase*",
		"*It's... technically correct*",
	])

	I.DestinationTag.add()
	await I.DestinationTag.add_popup()

	# Heat notification
	await E.queue([
		"A distant alarm blips.",
		"Someone noticed the tag destruction...",
	])


func execute_tag_fail_forward() -> void:
	"""Fail-forward: Wrong suitcase, baggage jam, souvenir hat."""
	state.wrong_suitcase = true

	await E.queue([
		"*Tank confidently climbs into a random suitcase*",
	])
	await C.Tank.say("This one feels right!")

	if GameState.has_party_member("Pig"):
		await C.player.say("That one says 'ALASKA'!")

	await E.queue([
		"*The conveyor lurches forward*",
		"*30 seconds of cold, bumpy travel*",
		"*CLUNK* *CRASH* *BEEEEP*",
		"BAGGAGE JAM",
		"*The suitcase gets spit back out*",
	])

	await C.Tank.say("Oops! Wrong cave!")

	# Consolation prize
	I.SouvenirHat.add()
	await E.queue([
		"At least Tank found a souvenir hat in there!",
	])
	await I.SouvenirHat.add_popup()

	# Still need to solve the puzzle properly
	await D.SuitcaseChoice.start()

#endregion

#region Puzzle B: Keep Party Together

func execute_brains_rope_link() -> void:
	"""Brains solution: Use rope to link suitcases."""
	state.party_linked = true
	state.solution_link = "rope"
	GameState.solve_puzzle("keep_party_together", GameState.Approach.BRAINS)

	# Check if player has rope from earlier
	var has_rope: bool = I.Rope.is_in_inventory() or I.MoistRope.is_in_inventory()

	if has_rope:
		await E.queue([
			"*Tank pulls out the rope from their supplies*",
		])
		await C.Tank.say("Pig said to always keep rope handy!")
	else:
		await E.queue([
			"*Pig finds some baggage straps nearby*",
		])
		if GameState.has_party_member("Pig"):
			await C.player.say("These straps will work. Tie 'em together!")

	await E.queue([
		"*Tank ties the suitcases together*",
		"*Their suitcase and Mr. Snuggles' suitcase: now linked*",
	])
	await C.Tank.say("We're a suitcase train now!")

	I.ZipperPull.add()
	await E.queue([
		"*The zipper pull breaks off in Tank's hand*",
		"Could be useful as a small tool.",
	])
	await I.ZipperPull.add_popup()


func execute_bizarre_sound_follow() -> void:
	"""Bizarre solution: Follow deer tapping sounds."""
	state.party_linked = true
	state.solution_link = "sound"
	GameState.solve_puzzle("keep_party_together", GameState.Approach.BIZARRE)

	await E.queue([
		"*From inside the gray suitcase: tap tap tap*",
	])

	await C.Tank.say("Mr. Snuggles is talking!")

	if GameState.has_party_member("Pig"):
		await C.player.say("He's tapping! Follow the sound!")

	await E.queue([
		"*tap tap tap* *tap*",
		"*Tank closes her eyes and listens*",
		"*tap tap*... there!",
		"*Tank navigates by sound alone*",
		"*The suitcases drift closer together*",
	])

	await C.Tank.say("Marco!")
	await E.queue([
		"*tap tap tap*",
		"Mr. Snuggles: (silent deer approval)",
	])

	I.ZipperPull.add()
	await I.ZipperPull.add_popup()

	# Morale bonus for teamwork
	GameState.add_morale(5)


func execute_brawn_belt_stop() -> void:
	"""Brawn solution: Shoulder-barge belt to stop it."""
	state.party_linked = true
	state.solution_link = "force"
	GameState.solve_puzzle("keep_party_together", GameState.Approach.BRAWN)
	GameState.add_heat(1)  # Loud

	await C.Tank.say("The floor won't take my friends!")
	await E.queue([
		"*Tank shoulder-barges the conveyor belt*",
		"*CRUNCH* *SCREEEECH*",
		"*The entire belt grinds to a halt*",
	])

	if GameState.has_party_member("Pig"):
		await C.player.say("That's... one way to do it.")

	await E.queue([
		"*Alarms blare in the distance*",
		"*Tank grabs Mr. Snuggles' suitcase*",
	])
	await C.Tank.say("Got you!")

	I.ZipperPull.add()
	await I.ZipperPull.add_popup()


func execute_link_fail_forward() -> void:
	"""Fail-forward: Lose deer temporarily, reunion scene."""
	state.lost_deer_temporarily = true

	await E.queue([
		"*The suitcases drift apart*",
	])
	await C.Tank.say("MISTER SNUGGLES!")
	await E.queue([
		"*The gray suitcase disappears around a corner*",
	])

	if GameState.has_party_member("Pig"):
		await C.player.say("We lost him! He could end up anywhere!")

	await E.queue([
		"*Tense moment*",
		"*Then: a familiar gray suitcase bumps into them from behind*",
		"*tap tap tap*",
	])

	await C.Tank.say("He found US!")

	await E.queue([
		"Mr. Snuggles navigated the luggage maze on his own.",
		"He's smarter than he looks.",
	])

	# Morale hit but not catastrophic
	GameState.add_morale(-5)

#endregion


func complete_room() -> void:
	"""Called when both puzzles are solved."""
	if not state.room_complete:
		state.room_complete = true

		await E.queue([
			"*The linked suitcases roll toward the TEXAS gate*",
			"*BEEP* *BEEP* *BEEP*",
			"Barcode Station: TEXAS. PLANE HOLD 7.",
		])

		await C.Tank.say("We're going to the plane!")

		if GameState.has_party_member("Pig"):
			await C.player.say("Almost there. Just gotta survive the flight.")

		await E.queue([
			"*The suitcases are loaded into the plane's cargo hold*",
			"*Darkness. Engine rumble. They're airborne.*",
		])

		# Transition to final room
		E.goto_room("PlaneHold")


func _on_room_transition_started() -> void:
	set_process(false)
