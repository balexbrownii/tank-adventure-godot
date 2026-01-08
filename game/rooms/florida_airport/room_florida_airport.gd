@tool
extends PopochiuRoom
## Room 14 - Florida Airport Entrance
## Reach the luggage area without getting thrown out.
## Three solutions: Disguise, Distraction, or Emotional Support Deer.

const Data := preload('room_florida_airport_state.gd')
var state: Data = load("res://game/rooms/florida_airport/room_florida_airport.tres")

# Tank Vision labels
var vision_data: Dictionary = {
	"dock": {
		"tank_hover": "LAND ARRIVAL POINT",
		"tank_inspect": "We made it to FLORIDA! One step closer to CANADA!",
		"reality_hover": "Florida Dock",
		"reality_inspect": "A quiet Florida dock. The airport is nearby."
	},
	"car": {
		"tank_hover": "BORROWED LAND VESSEL",
		"tank_inspect": "This car agreed to help us! VERY GENEROUS!",
		"reality_hover": "Rental Car",
		"reality_inspect": "A car you... borrowed. Let's not think too hard about it."
	},
	"tree_line": {
		"tank_hover": "STEALTH FOREST",
		"tank_inspect": "Trees! Perfect for HIDING and SNEAKING!",
		"reality_hover": "Palm Trees",
		"reality_inspect": "A row of palm trees between the parking lot and the airport."
	},
	"airport_entrance": {
		"tank_hover": "SKY SHIP PORTAL",
		"tank_inspect": "This is where the SKY SHIPS live! INCREDIBLE!",
		"reality_hover": "Airport Main Entrance",
		"reality_inspect": "The main entrance. Security guards check people going in."
	},
	"maintenance_door": {
		"tank_hover": "SECRET PORTAL",
		"tank_inspect": "A hidden entrance! Only TRUE ADVENTURERS know about this!",
		"reality_hover": "Staff Door",
		"reality_inspect": "Employee entrance. Needs a keycard or a good disguise."
	},
	"luggage_carts": {
		"tank_hover": "BOX CHARIOTS",
		"tank_inspect": "Carts for carrying TREASURE BOXES!",
		"reality_hover": "Luggage Carts",
		"reality_inspect": "Airport luggage carts. Workers push these around constantly."
	}
}


func _on_room_entered() -> void:
	if state.visited_before:
		return

	state.visited_before = true

	# Arrival at Florida
	await E.queue([
		"*The party arrives in Florida*",
		"Tank: FLORIDA! THE LAND OF...!",
		"Pig: Airports and alligators.",
		"Tank: ...GATORS!",
	])

	await E.queue([
		"Pig: We need to get into that airport and onto a plane to Texas.",
		"Pig: From Texas, we can make our way north.",
		"Tank: WHY CAN'T WE JUST FLY TO CANADA?!",
		"Pig: ...have you seen us? We'd never get through security.",
	])

	await E.queue([
		"Mr. Snuggles: *looks at airport calmly*",
		"Pig: We need to get to the luggage area. Sneak onto a plane.",
		"Tank: STEALTH MISSION!",
		"Pig: *sighs* Yes, Tank. Stealth mission.",
	])


func _on_room_transition_started() -> void:
	pass


func trigger_entrance_puzzle() -> void:
	"""Start the airport entrance puzzle dialog."""
	D.AirportEntry.start()


# ===============================
# ENTRANCE SOLUTIONS
# ===============================

func execute_brains_solution() -> void:
	"""Brains solution: Disguise with vest and clipboard."""
	state.entered_airport = true
	state.entry_solution = "disguise"

	GameState.solve_puzzle("airport_entry", GameState.Approach.BRAINS)

	await E.queue([
		"Pig: I got an idea. See that cart?",
		"Pig: There's a vest and clipboard on it.",
		"Tank: COSTUMES!",
	])

	await E.queue([
		"*Tank puts on the reflective vest*",
		"*Pig holds the clipboard in his mouth*",
		"Pig: Just walk in like you own the place.",
	])

	# Add disguise items
	I.ReflectiveVest.add()
	I.Clipboard.add()

	await E.queue([
		"*The party walks past security*",
		"Guard: *glances* ...maintenance crew.",
		"Guard: *goes back to phone*",
		"Tank: *whispers* WE'RE INVISIBLE!",
		"Pig: *whispers* Shh!",
	])

	await _enter_airport()


func execute_brawn_solution() -> void:
	"""Brawn solution: Tank distracts by 'saving' someone."""
	state.entered_airport = true
	state.entry_solution = "distraction"

	GameState.solve_puzzle("airport_entry", GameState.Approach.BRAWN)

	await E.queue([
		"Tank: I HAVE A PLAN!",
		"Pig: Oh no.",
		"Tank: *runs toward entrance*",
	])

	await E.queue([
		"Tank: CITIZEN! THAT LUGGAGE CART IS ATTACKING YOU!",
		"Bystander: What? It's just rolling-",
		"Tank: *tackles empty cart*",
		"Tank: I'LL SAVE YOU!",
	])

	await E.queue([
		"*Chaos ensues*",
		"*Security rushes to the disturbance*",
		"Pig: Now! Through the door!",
		"*Pig and Mr. Snuggles slip inside*",
		"Tank: *catches up later* Did it work?!",
		"Pig: Somehow.",
	])

	GameState.add_heat(1)
	await _enter_airport()


func execute_bizarre_solution() -> void:
	"""Bizarre solution: Emotional Support Deer."""
	state.entered_airport = true
	state.entry_solution = "support_deer"

	GameState.solve_puzzle("airport_entry", GameState.Approach.BIZARRE)

	await E.queue([
		"Tank: Mr. Snuggles! Use your OFFICIAL POWERS!",
		"Pig: What official- oh no.",
	])

	await E.queue([
		"*Tank finds a 'Service Animal' vest somewhere*",
		"*Puts it on Mr. Snuggles*",
		"Tank: He is my EMOTIONAL SUPPORT DEER!",
	])

	await E.queue([
		"Guard: Ma'am, is that a deer?",
		"Tank: He helps with my ANXIETY!",
		"Mr. Snuggles: *looks extremely calm and professional*",
		"Guard: ...I guess that checks out.",
	])

	await E.queue([
		"*The party walks through the 'Service Animal' lane*",
		"Pig: I can't believe that worked.",
		"Tank: Mr. Snuggles is OFFICIALLY SUPPORTIVE!",
	])

	GameState.add_morale(5)
	await _enter_airport()


func execute_fail_forward() -> void:
	"""Fail-forward: Caught, sent to gift shop, escape through postcard rack."""
	state.entered_airport = true
	state.entry_solution = "fail_forward"
	state.went_through_gift_shop = true

	await E.queue([
		"Guard: Hey! You can't bring a deer in here!",
		"Tank: But-",
		"Guard: Gift shop. NOW.",
	])

	await E.queue([
		"*The party is escorted to the airport gift shop*",
		"Pig: Well, this is great.",
		"Tank: *looks around*",
		"Tank: *notices rotating postcard rack*",
	])

	await E.queue([
		"Tank: I HAVE AN IDEA!",
		"*Tank spins the postcard rack HARD*",
		"*It knocks into a shelving unit*",
		"*Dominoes of merchandise create a path*",
	])

	await E.queue([
		"Pig: GO GO GO!",
		"*The party escapes through the chaos*",
		"*Somehow end up exactly where they needed to be*",
		"Pig: ...your dumb luck is honestly impressive.",
	])

	# Small Heat gain for the chaos
	GameState.add_heat(1)
	await _enter_airport()


func _enter_airport() -> void:
	"""Transition to the luggage room."""
	await E.queue([
		"*The party makes it to the luggage area*",
		"Pig: Okay. Now we need to find a suitcase going to Texas.",
		"Tank: INFILTRATION COMPLETE!",
	])

	E.goto_room("LuggageRoom")


func check_vest_location() -> void:
	"""Player looks for disguise items."""
	if state.entered_airport:
		await C.Tank.say("We already got in!")
		return

	if TankVision.is_reality_mode:
		await E.queue([
			"*A reflective vest and clipboard sit on an unattended cart*",
			"*Workers wear these to blend in*",
		])
	else:
		await E.queue([
			"Tank: SHINY ARMOR! And a WRITING SHIELD!",
		])
