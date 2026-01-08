@tool
extends PopochiuRoom
## Room 3 - Ditch Hideout
## Tank waits in the ditch; wolf leaves; she falls asleep.
## Sets up the "leg miracle" reveal for Room 4.

const Data := preload('room_ditch_hideout_state.gd')
var state: Data = load("res://game/rooms/ditch_hideout/room_ditch_hideout.tres")

# Tank Vision labels for all hotspots
var vision_data: Dictionary = {
	"leaf_pile": {
		"tank_hover": "LEG VOID",
		"tank_inspect": "The darkness where my leg USED to be... I can't even look at it...",
		"reality_hover": "Leaf Pile",
		"reality_inspect": "A pile of fallen leaves. Something lumpy is underneath."
	},
	"ditch_wall": {
		"tank_hover": "EARTH EMBRACE",
		"tank_inspect": "The walls of my earthen refuge! They witnessed my TRAGEDY!",
		"reality_hover": "Ditch Wall",
		"reality_inspect": "Dirt walls. Roots poke through. Surprisingly cozy."
	},
	"backpack": {
		"tank_hover": "SURVIVAL POUCH",
		"tank_inspect": "My trusty pack! It has seen me through SO MUCH already!",
		"reality_hover": "Backpack",
		"reality_inspect": "Your dirty backpack. Still has some supplies."
	},
	"moonlight_gap": {
		"tank_hover": "HEAVEN SPOTLIGHT",
		"tank_inspect": "The moon watches over me! Even in my DARKEST hour!",
		"reality_hover": "Gap in Branches",
		"reality_inspect": "Moonlight filtering through tree branches above."
	},
	"loose_roots": {
		"tank_hover": "NATURE ROPES",
		"tank_inspect": "Strong fibers! Good for... something. Punching? Tying?",
		"reality_hover": "Exposed Roots",
		"reality_inspect": "Dangling roots from the ditch wall. Could be useful for crafting."
	},
	"small_puddle": {
		"tank_hover": "WARRIOR MIRROR",
		"tank_inspect": "I see a brave fighter reflected in these waters...",
		"reality_hover": "Small Puddle",
		"reality_inspect": "Muddy water collected at the ditch bottom. Not drinkable."
	}
}


func _on_room_entered() -> void:
	if state.visited_before:
		return

	state.visited_before = true

	# Intro sequence - Tank just escaped into the ditch
	await E.queue([
		"Tank: *panting* I... I made it...",
		"Tank: The wolf is gone. For now.",
		A.sfx_wolf_howl_distant.play() if A.has_sound("sfx_wolf_howl_distant") else null,
		"Tank: *shudder* I should rest here until morning.",
		"Tank: But first... I need to make camp.",
	])

	# Set up wolf patrol state
	state.wolf_left = true


func _on_room_transition_started() -> void:
	pass


func trigger_camp_setup() -> void:
	"""Called when player attempts to sleep or after enough exploration."""
	if state.camp_made:
		return

	await E.queue([
		"Tank: Time to settle in for the night.",
		"Tank: This ditch isn't much, but it's home for now.",
	])

	# Start the camp dialog
	D.MakeCamp.start()


func execute_standard_solution() -> void:
	"""Standard solution: Use leaf pile as blanket."""
	state.camp_made = true
	state.solution_used = "standard"
	state.has_leaf_blanket = true

	await E.queue([
		"Tank: These leaves look... soft enough.",
		"Tank: *gathers leaves*",
		"Tank: There! A perfect warrior's blanket!",
	])

	# Add leaf blanket to inventory
	I.LeafBlanket.add()

	await execute_sleep_sequence()


func execute_brains_solution() -> void:
	"""Brains solution: Combine leaves + roots for better blanket."""
	state.camp_made = true
	state.solution_used = "brains"
	state.has_leaf_wrap = true

	GameState.solve_puzzle("ditch_camp", GameState.Approach.BRAINS)

	await E.queue([
		"Tank: Hmm... if I weave these roots through the leaves...",
		"Tank: *carefully crafts*",
		"Tank: A LEAF WRAP! It's like a blanket but... wrappier!",
		"Tank: Pig would be proud! If I knew who Pig was!",
	])

	# Add better item
	I.LeafWrap.add()
	I.RootFiber.add()  # Bonus item

	await execute_sleep_sequence()


func execute_brawn_solution() -> void:
	"""Brawn solution: Punch the ground to make a bed."""
	state.camp_made = true
	state.solution_used = "brawn"
	state.punched_ground = true

	GameState.solve_puzzle("ditch_camp", GameState.Approach.BRAWN)
	GameState.add_heat(1)  # Loud!

	await E.queue([
		"Tank: The ground isn't soft enough? I'LL MAKE IT SOFT!",
		"Tank: HYAAAA!",
		A.sfx_punch_ground.play() if A.has_sound("sfx_punch_ground") else null,
		"*THUD* *THUD* *THUD*",
		"Tank: There! A perfectly Tank-shaped bed crater!",
	])

	# Distant wolf howl - noise attracted attention
	await E.queue([
		A.sfx_wolf_howl_distant.play() if A.has_sound("sfx_wolf_howl_distant") else null,
		"Tank: ...Was that the wolf?",
		"Tank: Nah. Probably just... wind.",
	])

	await execute_sleep_sequence()


func execute_fail_forward() -> void:
	"""Fail-forward: No blanket - Tank invents suffering."""
	state.camp_made = true
	state.solution_used = "fail_forward"
	state.no_blanket = true

	await E.queue([
		"Tank: I don't need a blanket! Warriors sleep on the COLD HARD GROUND!",
		"Tank: Besides, what's the worst that could happen?",
		"Tank: *lies down*",
		"Tank: See? Perfectly comf-",
		"Tank: *immediately falls asleep*",
	])

	await execute_sleep_sequence()


func execute_sleep_sequence() -> void:
	"""The sleep sequence that sets up Room 4."""
	await E.queue([
		"...",
		"*Hours pass*",
		"*The moon drifts across the sky*",
	])

	# Set up the leg pile - this is the crucial setup for Room 4
	state.leg_under_leaves = true

	await E.queue([
		"*Tank shifts in her sleep*",
		"*Her leg slides under the leaf pile*",
	])

	# If no blanket, she wakes up "injured"
	if state.no_blanket:
		state.invented_injury = true
		await E.queue([
			"*Morning light filters through the branches*",
			"Tank: *waking up* Uuuugh...",
			"Tank: Everything... hurts...",
			"Tank: I think... I think the wolf got me in the night!",
			"Tank: MY LEG! I CAN'T FEEL MY LEG!",
		])
	else:
		await E.queue([
			"*Morning light filters through the branches*",
			"Tank: *waking up* Mmm... what a nice sleep...",
			"Tank: Wait. Something's wrong.",
			"Tank: MY LEG! WHERE IS MY LEG?!",
		])

	# Transition to Room 4 - Morning Miracle
	await E.queue([
		"Tank: *looking at leaf pile in horror*",
		"Tank: The wolf... it must have... while I was sleeping...",
		"Tank: MY LEG IS GONE!",
	])

	# Room transition
	E.goto_room("MorningMiracle")


func take_leaf_pile() -> void:
	"""Take leaves from the pile before sleeping."""
	if state.took_leaves:
		await C.Tank.say("I already gathered what I needed from there.")
		return

	state.took_leaves = true
	I.LeafBlanket.add()

	await E.queue([
		"Tank: *grabs armful of leaves*",
		"Tank: These will make a cozy blanket!",
	])


func take_root_fiber() -> void:
	"""Pull some root fiber from the wall."""
	if state.took_roots:
		await C.Tank.say("I already took some roots.")
		return

	state.took_roots = true
	I.RootFiber.add()

	await E.queue([
		"Tank: *tugs on roots*",
		"Tank: Strong and fibrous! Good for tying things!",
	])


func take_charcoal() -> void:
	"""Take optional charcoal chunk from a burned spot."""
	if state.took_charcoal:
		await C.Tank.say("I already got the charcoal.")
		return

	state.took_charcoal = true
	I.CharcoalChunk.add()

	await E.queue([
		"Tank: *scrapes charcoal*",
		"Tank: Could use this to write... or smear on my face for STEALTH!",
	])


func examine_puddle() -> void:
	"""Look at reflection in puddle."""
	var text: String = TankVision.get_inspect_text(vision_data["small_puddle"])
	await C.Tank.say(text)

	if not TankVision.is_reality_mode:
		await E.queue([
			"Tank: *strikes heroic pose*",
			"Tank: Even in defeat, I look AMAZING.",
		])
	else:
		await E.queue([
			"Tank: I look... muddy.",
			"Tank: Very, very muddy.",
		])
