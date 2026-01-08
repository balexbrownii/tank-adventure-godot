@tool
extends PopochiuRoom
## Room 16 - Plane Hold: Crash Landing (FINALE)
## The cliffhanger ending. Crash prep puzzle, then impact.

var state = preload("res://game/rooms/plane_hold/room_plane_hold.tres")

## Vision data for Tank/Reality label differences
var vision_data: Dictionary = {
	"siren_light": {
		"tank_hover": "BLINKY DISCO BALL",
		"tank_inspect": "Ooh, party lights! Wait, why is everyone screaming?",
		"reality_hover": "Emergency Siren",
		"reality_inspect": "Emergency warning system. This is not good."
	},
	"life_vests": {
		"tank_hover": "FLOATY PILLOWS",
		"tank_inspect": "Comfy pillows! I'll wear one as a fashion statement!",
		"reality_hover": "Emergency Life Vests",
		"reality_inspect": "Aircraft safety equipment. Put them on everyone. Now."
	},
	"cargo_straps": {
		"tank_hover": "SEATBELT FRIENDS",
		"tank_inspect": "These straps want to hug us!",
		"reality_hover": "Cargo Securing Straps",
		"reality_inspect": "Industrial tie-downs. Could secure the deer suitcase."
	},
	"instruction_card": {
		"tank_hover": "PICTURE BOOK",
		"tank_inspect": "A picture book! It shows people... bending? Are they dancing?",
		"reality_hover": "Emergency Instruction Card",
		"reality_inspect": "Crash landing procedures. Brace position. This is really happening."
	},
	"deer_latch": {
		"tank_hover": "DEER HOUSE DOOR",
		"tank_inspect": "Mr. Snuggles' door! Should I let him out?",
		"reality_hover": "Suitcase Latch",
		"reality_inspect": "If we crash, this latch could pop open. Secure it."
	},
	"loose_baggage": {
		"tank_hover": "SHIELD COLLECTION",
		"tank_inspect": "Look at all these potential shields! I am INVINCIBLE!",
		"reality_hover": "Unsecured Cargo",
		"reality_inspect": "Flying debris risk. Could use as padding... or lose everything."
	}
}


func _on_room_entered() -> void:
	set_process(true)

	if not state.visited:
		state.visited = true
		await _play_entry_sequence()


func _play_entry_sequence() -> void:
	"""The opening sequence - siren starts, announcement plays."""
	await E.queue([
		"*The plane hums steadily*",
		"*Tank, Pig, and Mr. Snuggles are in the cargo hold*",
		"*Hidden among the luggage*",
	])

	await C.Tank.say("This is nice! Like camping in a flying cave!")

	if GameState.has_party_member("Pig"):
		await C.player.say("Shhh. We're almost to Texas. Just a few more hours.")

	await E.queue([
		"*Silence. Engine drone.*",
		"*Then—*",
	])

	# The moment everything changes
	await _play_emergency_sequence()


func _play_emergency_sequence() -> void:
	"""The emergency announcement and siren."""
	await E.queue([
		"*BWEEE BWEEE BWEEE*",
		"The red warning light starts flashing.",
	])

	await C.Tank.say("Ooh, disco!")

	await E.queue([
		"PILOT (intercom): This is your captain speaking.",
		"PILOT (intercom): We are experiencing... severe turbulence.",
		"*The plane shudders violently*",
		"PILOT (intercom): Please prepare for an emergency landing.",
		"PILOT (intercom): Brace for impact.",
	])

	if GameState.has_party_member("Pig"):
		await C.player.say("Emergency landing?! Where?!")

	await E.queue([
		"PILOT (intercom): Current position... over the Amazon rainforest.",
		"PILOT (intercom): I repeat. BRACE FOR IMPACT.",
	])

	await C.Tank.say("Amazon? Isn't that where I started?!")

	if GameState.has_party_member("Pig"):
		await C.player.say("We're going to CRASH!")

	await E.queue([
		"*The cargo hold tilts*",
		"*Luggage slides*",
		"*Time slows down*",
	])

	# Start the crash prep puzzle
	await D.CrashPrep.start()


#region Crash Prep Solutions

func execute_brains_full_prep() -> void:
	"""Brains solution: Full emergency prep - vests, straps, stow items."""
	state.crash_prepped = true
	state.prep_type = "full"
	GameState.solve_puzzle("crash_prep", GameState.Approach.BRAINS)

	await E.queue([
		"*Pig takes charge*",
	])

	if GameState.has_party_member("Pig"):
		await C.player.say("LISTEN TO ME! Vests on! Strap the deer! Stow everything!")

	await E.queue([
		"*Tank snaps into action*",
		"*Life vest on Tank*",
		"*Life vest on Pig*",
		"*Mr. Snuggles' suitcase strapped down*",
		"*Inventory items secured*",
	])

	await C.Tank.say("We're ready!")

	state.items_saved = true
	state.deer_secured = true

	await _execute_crash()


func execute_brawn_human_shield() -> void:
	"""Brawn solution: Tank braces as human seatbelt for everyone."""
	state.crash_prepped = true
	state.prep_type = "brawn"
	GameState.solve_puzzle("crash_prep", GameState.Approach.BRAWN)

	await C.Tank.say("I'LL PROTECT EVERYONE!")
	await E.queue([
		"*Tank wraps her massive arms around Pig and the deer suitcase*",
	])

	if GameState.has_party_member("Pig"):
		await C.player.say("Tank, what are you—")

	await C.Tank.say("I am a HUMAN SEATBELT!")
	await E.queue([
		"*Tank's muscles flex*",
		"*Her backpack falls, spilling items*",
	])

	state.deer_secured = true
	state.items_saved = false  # Lose some items

	await _execute_crash()


func execute_bizarre_calm_deer() -> void:
	"""Bizarre solution: Calm Mr. Snuggles with breathing exercise."""
	state.crash_prepped = true
	state.prep_type = "calm"
	GameState.solve_puzzle("crash_prep", GameState.Approach.BIZARRE)

	await E.queue([
		"*Mr. Snuggles starts panicking inside his suitcase*",
		"*The suitcase shakes violently*",
	])

	await C.Tank.say("Mr. Snuggles! Remember what Pig taught us!")

	if GameState.has_party_member("Pig"):
		await C.player.say("The breathing thing?!")

	await E.queue([
		"*Tank presses her forehead against the suitcase*",
	])
	await C.Tank.say("Breathe in... two... three... four...")
	await E.queue([
		"*tap... tap... tap...*",
	])
	await C.Tank.say("Breathe out... two... three... four...")
	await E.queue([
		"*The shaking slows*",
		"*Calm.*",
	])

	state.deer_secured = true
	state.items_saved = true
	GameState.modify_morale(10)  # Best morale for jungle start

	await _execute_crash()


func execute_fail_forward_panic() -> void:
	"""Fail-forward: Do nothing - survive with plastic spoons."""
	state.crash_prepped = true
	state.prep_type = "panic"

	await E.queue([
		"*Tank freezes*",
	])
	await C.Tank.say("I don't... what do I...")

	if GameState.has_party_member("Pig"):
		await C.player.say("TANK! DO SOMETHING!")

	await C.Tank.say("I... I feel warm...")
	await E.queue([
		"*Tank's mind goes blank*",
		"*The world tilts*",
	])

	state.deer_secured = false  # Deer separated
	state.items_saved = false
	state.got_plastic_spoons = true  # Comedy consolation

	await _execute_crash()

#endregion


func _execute_crash() -> void:
	"""The crash sequence - the climax."""
	await E.queue([
		"",
		"*3*",
		"",
		"*2*",
		"",
		"*1*",
		"",
	])

	# The impact
	await _play_crash_impact()


func _play_crash_impact() -> void:
	"""The actual crash and aftermath setup."""
	await E.queue([
		"*IMPACT*",
		"",
		"*Sound cuts out*",
		"",
		"*...*",
		"",
		"*...*",
		"",
		"*...*",
	])

	# Tone shift - Norco-style somber
	await _play_aftermath()


func _play_aftermath() -> void:
	"""Post-crash - setting up the cliffhanger."""
	await E.queue([
		"",
		"*Birds.*",
		"",
		"*Distant.*",
		"",
		"*Sunlight through leaves.*",
		"",
	])

	# Different aftermath based on prep
	match state.prep_type:
		"full":
			await E.queue([
				"*Tank opens her eyes*",
				"*Life vest intact. Pig nearby. Deer suitcase beside her.*",
				"*Everything hurts, but everyone is here.*",
			])
		"brawn":
			await E.queue([
				"*Tank's arms are still wrapped around her friends*",
				"*Bruised. Battered. But together.*",
				"*Her backpack is gone. Items scattered.*",
			])
		"calm":
			await E.queue([
				"*Mr. Snuggles' calm breathing echoes in Tank's mind*",
				"*She opens her eyes. The deer is pressed against her.*",
				"*Peace in chaos.*",
			])
		"panic", _:
			await E.queue([
				"*Tank wakes to confusion*",
				"*Where is everyone? Where are her things?*",
				"*In her hand: 12 plastic spoons.*",
				"*How?*",
			])

	# The final lines
	await _play_ending()


func _play_ending() -> void:
	"""The cliffhanger ending."""
	await E.queue([
		"",
		"*Tank sits up.*",
		"",
		"*She looks around.*",
		"",
		"*Trees. Jungle. Not Texas.*",
		"",
	])

	await C.Tank.say("...")

	await E.queue([
		"",
		"*Tank takes a deep breath.*",
		"",
	])

	# Final line - different based on state
	if state.deer_secured and state.items_saved:
		await C.Tank.say("We made it.")
	elif state.deer_secured:
		await C.Tank.say("At least we're together.")
	else:
		await C.Tank.say("I have to find them.")

	await E.queue([
		"",
		"*She stands.*",
		"",
		"*The jungle stretches endlessly.*",
		"",
		"*Somewhere, a wolf howls.*",
		"",
	])

	# Credits/Cliffhanger
	await _play_credits()


func _play_credits() -> void:
	"""The TO BE CONTINUED screen."""
	state.ending_reached = true

	await E.queue([
		"",
		"",
		"",
		"════════════════════════════════════════",
		"",
		"            TO BE CONTINUED",
		"",
		"════════════════════════════════════════",
		"",
		"",
	])

	# Stats based on playthrough
	await _show_playthrough_stats()

	await E.queue([
		"",
		"",
		"═══════════════════════════════════════════════════",
		"",
		"    SEASON 2: BOOK TWO - THE AMAZON AWAKENS",
		"",
		"                   Coming Soon",
		"",
		"═══════════════════════════════════════════════════",
		"",
	])

	# Final message
	await E.queue([
		"",
		"Thank you for playing Tank's Great Adventure!",
		"",
		"This story was created by a kid with a big imagination.",
		"And built with love by their family.",
		"",
	])


func _show_playthrough_stats() -> void:
	"""Show the player's stats and achievements."""
	var brains_count: int = GameState.get_approach_count(GameState.Approach.BRAINS)
	var brawn_count: int = GameState.get_approach_count(GameState.Approach.BRAWN)
	var bizarre_count: int = GameState.get_approach_count(GameState.Approach.BIZARRE)

	await E.queue([
		"",
		"Your Journey:",
		"",
		"  Brains solutions: " + str(brains_count),
		"  Brawn solutions: " + str(brawn_count),
		"  Bizarre solutions: " + str(bizarre_count),
		"",
	])

	# Achievements
	if GameState.is_maximum_tank():
		await E.queue(["  [ACHIEVEMENT] MAXIMUM TANK - All Brawn solutions!"])
	if GameState.is_pigs_pride():
		await E.queue(["  [ACHIEVEMENT] PIG'S PRIDE - All Brains solutions!"])
	if GameState.is_what_just_happened():
		await E.queue(["  [ACHIEVEMENT] WHAT JUST HAPPENED - All Bizarre solutions!"])
	if GameState.is_perfectly_balanced():
		await E.queue(["  [ACHIEVEMENT] PERFECTLY BALANCED - Equal approaches!"])

	# Morale/Heat final state
	await E.queue([
		"",
		"  Final Heat level: " + str(GameState.heat),
		"  Final Morale: " + str(GameState.morale),
		"",
	])


func _on_room_transition_started() -> void:
	set_process(false)
