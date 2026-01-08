@tool
extends PopochiuRoom
## Room 13 - Puerto Rico: Motel + Back Dock
## Secure a night's rest, then "borrow" a boat for Florida.
## Two-part puzzle: get a room, then get a boat.

const Data := preload('room_puerto_rico_state.gd')
var state: Data = load("res://game/rooms/puerto_rico/room_puerto_rico.tres")

# Tank Vision labels
var vision_data: Dictionary = {
	"motel_desk": {
		"tank_hover": "REST FORTRESS COMMAND CENTER",
		"tank_inspect": "The keeper of the REST FORTRESS! They control who sleeps!",
		"reality_hover": "Front Desk",
		"reality_inspect": "A bored clerk reads a magazine. Looks easy to negotiate with."
	},
	"vending_machine": {
		"tank_hover": "FOOD PRISON",
		"tank_inspect": "FOOD is trapped in there! We must FREE IT!",
		"reality_hover": "Vending Machine",
		"reality_inspect": "Snacks and drinks. Takes coins or cards."
	},
	"room_door": {
		"tank_hover": "SLEEP CHAMBER ENTRANCE",
		"tank_inspect": "Beyond this door... REST!",
		"reality_hover": "Room 7",
		"reality_inspect": "Your assigned room. Looks clean enough."
	},
	"back_dock": {
		"tank_hover": "SECRET WATER PATH",
		"tank_inspect": "A hidden path to the SEA! Adventure awaits!",
		"reality_hover": "Motel Back Dock",
		"reality_inspect": "A small dock behind the motel. A few boats are tied up."
	},
	"boat": {
		"tank_hover": "SEA CAR",
		"tank_inspect": "A LAND CAR but for WATER! Incredible!",
		"reality_hover": "Small Motorboat",
		"reality_inspect": "An older boat that looks seaworthy. Needs a key or permission."
	},
	"camera": {
		"tank_hover": "SPY EYEBALL",
		"tank_inspect": "It SEES ALL! We must avoid its GAZE!",
		"reality_hover": "Security Camera (fake)",
		"reality_inspect": "A fake security camera with googly eyes. Not even plugged in."
	}
}


func _on_room_entered() -> void:
	if state.visited_before:
		return

	state.visited_before = true

	# Arrival at Puerto Rico
	await E.queue([
		"*The raft reaches Puerto Rico*",
		"Tank: LAND!",
		"Pig: Finally. My hooves are soaked.",
		"Mr. Snuggles: *shakes water from fur*",
	])

	# Check if alternate beach from sandbar fail-forward
	if R.CaribbeanRaft.state.alternate_beach:
		await E.queue([
			"*You've arrived at a quieter beach on the north side*",
			"Pig: This ain't where I planned, but there's a motel nearby.",
		])
	else:
		await E.queue([
			"*You've arrived exactly where Pig planned*",
			"Pig: Perfect navigation. There's a motel just up the road.",
		])

	await E.queue([
		"Pig: We need rest before the next leg. Florida's a long sail.",
		"Tank: SLEEP! Then more ADVENTURE!",
		"Mr. Snuggles: *yawns*",
	])


func _on_room_transition_started() -> void:
	pass


func trigger_room_puzzle() -> void:
	"""Start the 'get a room' dialog."""
	D.GetRoom.start()


func trigger_boat_puzzle() -> void:
	"""Start the 'get a boat' dialog."""
	if not state.got_room:
		await E.queue([
			"Pig: Let's rest first. We ain't stealin' nothin' tired.",
		])
		return

	D.GetBoat.start()


# ===============================
# PUZZLE A: GET A ROOM
# ===============================

func execute_room_brains_solution() -> void:
	"""Brains solution: Trade goods for room."""
	state.got_room = true
	state.room_solution = "trade"

	GameState.solve_puzzle("get_room", GameState.Approach.BRAINS)

	await E.queue([
		"Tank: We have TRIBUTE!",
		"Pig: *sighs* ...I'll handle this.",
	])

	# Check what player has to trade
	if I.MiniDonuts.is_in_inventory():
		await E.queue([
			"Pig: Ma'am, we've had a long journey. Got some donuts to trade for a room.",
			"Clerk: *perks up* Donuts?",
			"Clerk: Room 7. One night.",
			"*Traded: Mini Donuts*",
		])
		I.MiniDonuts.remove()
	elif I.SpinachLeaves.is_in_inventory():
		await E.queue([
			"Pig: How about some fresh spinach? Good for ya.",
			"Clerk: ...that's weird, but okay. Room 7.",
			"*Traded: Spinach Leaves*",
		])
		I.SpinachLeaves.remove()
	else:
		await E.queue([
			"Pig: We don't have much, but we're desperate.",
			"Clerk: *looks at tired party*",
			"Clerk: Fine. Room 7. Just... don't break anything.",
		])

	await _room_sequence()


func execute_room_bizarre_solution() -> void:
	"""Bizarre solution: Charm with cute deer."""
	state.got_room = true
	state.room_solution = "charm"

	GameState.solve_puzzle("get_room", GameState.Approach.BIZARRE)

	await E.queue([
		"Pig: Ma'am, my friend here has somethin' to say.",
		"Mr. Snuggles: *approaches desk*",
		"Mr. Snuggles: *big doe eyes*",
		"Mr. Snuggles: *gentle head tilt*",
	])

	await E.queue([
		"Clerk: Oh my GOD he's adorable.",
		"Clerk: You can have ANY room!",
		"Clerk: Can I... can I pet him?",
		"Mr. Snuggles: *allows gentle pets*",
		"Tank: He's a MASTER OF NEGOTIATION!",
	])

	await _room_sequence()


func execute_room_brawn_solution() -> void:
	"""Brawn solution: Tank intimidates."""
	state.got_room = true
	state.room_solution = "intimidate"

	GameState.solve_puzzle("get_room", GameState.Approach.BRAWN)

	await E.queue([
		"Tank: *steps forward*",
		"Tank: WE. NEED. A ROOM.",
		"Clerk: *stares at Tank's muscles*",
		"Clerk: Room 7. Take it. Please.",
	])

	await E.queue([
		"Pig: Tank! We coulda been nice about it!",
		"Tank: I WAS nice! I didn't even flex!",
		"*Morale -1 (Pig is embarrassed)*",
	])

	GameState.modify_morale(-1)
	await _room_sequence()


func execute_room_fail_forward() -> void:
	"""Fail-forward: Sleep outside."""
	state.got_room = false
	state.room_solution = "fail"
	state.slept_outside = true

	await E.queue([
		"Clerk: No room available. Try down the road.",
		"Tank: But I see empty rooms!",
		"Clerk: Sorry. Policy.",
		"Pig: *grumbles*",
	])

	await E.queue([
		"*The party sleeps behind the motel*",
		"*Pig does not sleep well*",
		"*'Cranky Pig' debuff: Hints cost double*",
	])

	# Flag for hint cost increase
	state.cranky_pig = true


func _room_sequence() -> void:
	"""Common sequence after getting room."""
	I.MotelKeycard.add()

	await E.queue([
		"*The party rests in Room 7*",
		"*Several hours later...*",
		"Pig: Okay. Before dawn. Time to get a boat.",
		"Tank: STEALTH MISSION!",
		"Pig: Please don't call it that.",
	])


# ===============================
# PUZZLE B: GET A BOAT
# ===============================

func execute_boat_brains_solution() -> void:
	"""Brains solution: Find permission slip, get stamp."""
	state.got_boat = true
	state.boat_solution = "permission"

	GameState.solve_puzzle("get_boat", GameState.Approach.BRAINS)

	await E.queue([
		"Pig: Wait... there's a 'Boat Borrow Form' posted here.",
		"Tank: PAPERWORK?!",
		"Pig: It's how civilized folk do things.",
	])

	await E.queue([
		"*Pig fills out the form*",
		"*Returns to front desk for stamp*",
		"Clerk: *half asleep* Boat rental? Sure...",
		"*STAMP*",
		"Pig: Thank ya kindly.",
	])

	await E.queue([
		"*The party legally borrows a boat*",
		"Tank: That was... easy?",
		"Pig: That's how it works when you ain't breakin' laws.",
	])

	I.BoatToken.add()
	_boat_sequence()


func execute_boat_brawn_solution() -> void:
	"""Brawn solution: Tank lifts boat."""
	state.got_boat = true
	state.boat_solution = "lift"

	GameState.solve_puzzle("get_boat", GameState.Approach.BRAWN)

	await E.queue([
		"Tank: I'LL GET THE BOAT!",
		"Pig: Tank, wait-",
		"Tank: *picks up entire boat*",
	])

	await E.queue([
		"Pig: ...how are you even doin' that?",
		"Tank: MUSCLES!",
		"*Tank carries boat to water*",
		"*SPLASH*",
	])

	await E.queue([
		"*Someone in the distance*",
		"Voice: HEY! That's my boat!",
		"Tank: TIME TO GO!",
		"*Heat +1 (loud boat theft)*",
	])

	GameState.add_heat(1)
	_boat_sequence()


func execute_boat_bizarre_solution() -> void:
	"""Bizarre solution: Teamwork - deer holds rope, Pig unties."""
	state.got_boat = true
	state.boat_solution = "teamwork"

	GameState.solve_puzzle("get_boat", GameState.Approach.BIZARRE)

	await E.queue([
		"Pig: Okay, here's the plan...",
		"Pig: Mista' Snuggles, hold this rope steady.",
		"Mr. Snuggles: *takes rope in mouth*",
		"Pig: Tank, distract the camera.",
	])

	await E.queue([
		"Tank: *waves at fake camera*",
		"Tank: HELLO SECURITY!",
		"Pig: *unties boat with hooves*",
		"Pig: For hooves, I'm pretty good at knots.",
	])

	await E.queue([
		"*The boat drifts free silently*",
		"*Mr. Snuggles guides it with the rope*",
		"Pig: Perfect teamwork.",
		"Tank: WE'RE LIKE A TEAM OF SPIES!",
		"Pig: Sure, Tank. Sure.",
	])

	_boat_sequence()


func _boat_sequence() -> void:
	"""Launch sequence after getting boat."""
	await E.queue([
		"*The party boards the boat*",
		"Pig: Next stop: Florida.",
		"Tank: ONE STEP CLOSER TO CANADA!",
		"Mr. Snuggles: *settles into boat*",
	])

	# Transition to next room (sailing sequence or Florida)
	E.goto_room("FloridaAirport")


func check_fake_camera() -> void:
	"""Player examines the fake camera."""
	if TankVision.is_reality_mode:
		await E.queue([
			"*On closer inspection, this is clearly fake*",
			"*The 'lens' is a googly eye*",
			"*There's not even a wire*",
		])
		state.knows_camera_fake = true
	else:
		await E.queue([
			"Tank: The SPY EYEBALL watches us!",
			"Tank: We must be EXTRA sneaky!",
		])


func check_vending_machine() -> void:
	"""Player checks vending machine."""
	if state.used_vending:
		await C.Tank.say("I already got a snack!")
		return

	await E.queue([
		"*The vending machine hums*",
		"Tank: Trapped food...",
	])

	if I.MotelKeycard.is_in_inventory():
		await E.queue([
			"*You swipe the keycard*",
			"*A bag of chips falls*",
			"Tank: FREEDOM FOR THE CHIPS!",
		])
		state.used_vending = true
		# Small morale boost
		GameState.modify_morale(1)
