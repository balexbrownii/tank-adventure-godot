@tool
extends PopochiuRoom
## Room 4 - Morning Miracle
## Tank wakes up thinking her leg is gone. THIS IS THE VISION TOGGLE TUTORIAL.
## Labels are DRAMATICALLY different between Tank Vision and Reality Vision.

const Data := preload('room_morning_miracle_state.gd')
var state: Data = load("res://game/rooms/morning_miracle/room_morning_miracle.tres")

# Tank Vision labels - DRAMATICALLY different to teach the toggle
var vision_data: Dictionary = {
	"leaf_pile": {
		"tank_hover": "THE VOID WHERE MY LEG WAS",
		"tank_inspect": "I can't look... my beautiful leg... GONE FOREVER!",
		"reality_hover": "Leaf Pile (lumpy)",
		"reality_inspect": "A pile of leaves. There's definitely something leg-shaped under there."
	},
	"numb_leg": {
		"tank_hover": "PHANTOM PAIN ZONE",
		"tank_inspect": "The ghost of my leg haunts me! I can feel it even though it's GONE!",
		"reality_hover": "Your Leg (asleep)",
		"reality_inspect": "Your leg. It fell asleep from being under the leaves. Pins and needles."
	},
	"rock_marker": {
		"tank_hover": "MEMORIAL STONE",
		"tank_inspect": "This rock shall mark where I lost my leg in glorious battle!",
		"reality_hover": "Random Rock",
		"reality_inspect": "Just a rock. You almost tripped on it earlier."
	},
	"backpack_strap": {
		"tank_hover": "SURVIVAL LIFELINE",
		"tank_inspect": "My pack! My only connection to my former two-legged life!",
		"reality_hover": "Backpack Strap",
		"reality_inspect": "Your backpack strap. It's twisted but functional."
	}
}

var pretend_struggle_count: int = 0
var scream_miracle_count: int = 0


func _on_room_entered() -> void:
	if state.visited_before:
		return

	state.visited_before = true

	# Check state from Room 3
	var ditch_state = R.DitchHideout.state if R.DitchHideout else null
	var had_blanket = ditch_state.has_leaf_blanket or ditch_state.has_leaf_wrap if ditch_state else false

	# Intro sequence - Tank wakes up
	await E.queue([
		"*Morning light streams through the branches*",
		"Tank: *waking up* Mmm... what a....",
		"Tank: Wait.",
	])

	# The dramatic realization
	await E.queue([
		"Tank: *looks down*",
		"Tank: WHERE IS MY LEG?!",
		"Tank: *gasp*",
		"Tank: THE WOLF! It must have... while I was sleeping...",
		"Tank: MY LEG IS GONE!",
	])

	# Tutorial prompt
	await E.queue([
		"*Something feels off about this situation...*",
		"*Press TAB to toggle your perspective*",
	])


func _on_room_transition_started() -> void:
	pass


func execute_brains_solution() -> void:
	"""Reality/Brains solution: Examine leaf pile → pull off leaves → leg revealed."""
	state.leg_revealed = true
	state.solution_used = "brains"

	GameState.solve_puzzle("morning_leg", GameState.Approach.BRAINS)

	await E.queue([
		"Tank: Wait... let me look at this 'void' more closely...",
		"Tank: *examines leaf pile*",
		"Tank: There's something under here...",
		"Tank: *pulls leaves away*",
		"Tank: My... my leg? It was here the whole time?",
	])

	await execute_leg_reveal()


func execute_brawn_solution() -> void:
	"""Tank/Brawn solution: Pretend struggle 3x → fall → leaves scatter."""
	state.leg_revealed = true
	state.solution_used = "brawn"

	GameState.solve_puzzle("morning_leg", GameState.Approach.BRAWN)

	await E.queue([
		"Tank: I will ADAPT! I will OVERCOME!",
		"Tank: *dramatic attempt to stand on one leg*",
		"Tank: *wobbles*",
		"Tank: *CRASH*",
		"*Tank falls directly onto the leaf pile, scattering leaves everywhere*",
		"Tank: Ow! What the-",
		"Tank: MY LEG! It's... it's back!",
	])

	await execute_leg_reveal()


func execute_bizarre_solution() -> void:
	"""Bizarre solution: Scream MIRACLE repeatedly → screen shake → leaves fall."""
	state.leg_revealed = true
	state.solution_used = "bizarre"
	state.achieved_miracle_screamer = true

	GameState.solve_puzzle("morning_leg", GameState.Approach.BIZARRE)

	await E.queue([
		"Tank: If my leg is truly gone... then I must SUMMON IT BACK!",
		"Tank: MIRACLE! MIRACLE! MIRACLE!",
		"*The screen shakes*",
		"*Birds fly away*",
		"*The leaves vibrate off the pile*",
		"Tank: IT WORKED! MY LEG HAS RETURNED!",
		"Tank: I am blessed with INCREDIBLE POWERS!",
	])

	# Achievement!
	await E.queue([
		"*ACHIEVEMENT UNLOCKED: Miracle Screamer*",
	])

	await execute_leg_reveal()


func execute_leg_reveal() -> void:
	"""Common leg reveal sequence after any solution."""
	state.leg_awakened = true

	await E.queue([
		"Tank: *wiggles toes*",
		"Tank: *pins and needles*",
		"Tank: Ow ow ow! The blood is returning!",
	])

	# Grant Miracle Confidence buff
	GameState.add_temporary_status("miracle_confidence")

	await E.queue([
		"Tank: This is a SIGN! I am INVINCIBLE!",
		"*Gained: Miracle Confidence*",
		"*Tank will attempt bold options first for the next few rooms*",
	])

	# Tutorial moment
	await E.queue([
		"*Did you notice how differently things looked in Tank Vision vs Reality?*",
		"*Toggle between them with TAB to see the truth... or Tank's version of it.*",
	])


func execute_fail_forward() -> void:
	"""Refuse to interact: Pig teases later, miss achievement."""
	state.refused_to_interact = true
	state.solution_used = "fail_forward"

	await E.queue([
		"Tank: I... I can't face this...",
		"Tank: *sits dramatically*",
		"*Time passes*",
		"*Eventually, Tank's leg wakes up on its own*",
		"Tank: Wait... my leg? But how?",
	])

	# Flag for Pig teasing later
	state.pig_will_tease = true

	await E.queue([
		"*You missed the chance to discover the miracle yourself...*",
		"*Pig will definitely have something to say about this later.*",
	])


func trigger_pretend_struggle() -> void:
	"""Click 'pretend struggle' to build up to Brawn solution."""
	pretend_struggle_count += 1

	match pretend_struggle_count:
		1:
			await E.queue([
				"Tank: I must learn to WALK WITHOUT MY LEG!",
				"Tank: *hops dramatically*",
			])
		2:
			await E.queue([
				"Tank: Balance is KEY!",
				"Tank: *wobbles precariously*",
			])
		3:
			# Third try triggers the solution
			await execute_brawn_solution()


func trigger_scream_miracle() -> void:
	"""Click 'scream miracle' to build up to Bizarre solution."""
	scream_miracle_count += 1

	match scream_miracle_count:
		1:
			await E.queue([
				"Tank: MIRACLE!",
				"*The leaves rustle slightly*",
			])
		2:
			await E.queue([
				"Tank: MIRACLE!!",
				"*The birds look concerned*",
			])
		3:
			# Third scream triggers the solution
			await execute_bizarre_solution()


func check_numb_leg() -> void:
	"""Interact with the 'phantom pain zone' (actually just a numb leg)."""
	if state.leg_revealed:
		await C.Tank.say("My leg is fine now! Just a little tingly.")
		return

	if TankVision.is_reality_mode:
		# Reality Vision reveals the truth
		await E.queue([
			"Tank: Wait... I can FEEL something there...",
			"Tank: It's... pins and needles?",
			"Tank: Is my leg just... ASLEEP?",
		])
	else:
		# Tank Vision - dramatic phantom limb
		await E.queue([
			"Tank: The ghost of my leg! It haunts me!",
			"Tank: I can feel it even though I KNOW it's gone!",
		])
