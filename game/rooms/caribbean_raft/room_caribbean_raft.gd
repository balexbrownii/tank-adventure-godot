@tool
extends PopochiuRoom
## Room 12 - Caribbean Raft: Midnight Fog
## Navigate through fog and reach Puerto Rico.
## Case file dates; midnight; fog; raft hits land; "Land ahoy!"
## Atmospheric tone shift - quieter, moodier sequence.

const Data := preload('room_caribbean_raft_state.gd')
var state: Data = load("res://game/rooms/caribbean_raft/room_caribbean_raft.tres")

# Tank Vision labels - navigation focus
var vision_data: Dictionary = {
	"fog_wall": {
		"tank_hover": "THE GREAT MYSTERY CLOUD",
		"tank_inspect": "A wall of adventure! Who knows what's beyond!",
		"reality_hover": "Dense Fog Bank",
		"reality_inspect": "Visibility near zero. Need another way to navigate."
	},
	"moon": {
		"tank_hover": "NIGHT SUN",
		"tank_inspect": "The night sun watches our journey! ENCOURAGING!",
		"reality_hover": "Moon (obscured)",
		"reality_inspect": "Barely visible through the fog. Not helpful for navigation."
	},
	"stars": {
		"tank_hover": "SKY DOTS",
		"tank_inspect": "Pretty dots! I wonder if they mean anything!",
		"reality_hover": "Constellation Pattern",
		"reality_inspect": "The stars align with the route sketch. Follow the bright cluster."
	},
	"sound_cues": {
		"tank_hover": "MYSTERY SOUNDS",
		"tank_inspect": "Something's making noise out there! Friend or FOE?",
		"reality_hover": "Distant Gulls",
		"reality_inspect": "Seabirds mean land is nearby. Follow the sound."
	},
	"oar": {
		"tank_hover": "WATER SWORD",
		"tank_inspect": "My weapon against the SEA!",
		"reality_hover": "Paddle",
		"reality_inspect": "Used for steering. Match the rhythm of the waves."
	},
	"life_jacket": {
		"tank_hover": "MR. SNUGGLES' ARMOR",
		"tank_inspect": "Mr. Snuggles looks so PROTECTED!",
		"reality_hover": "Life Jacket (worn)",
		"reality_inspect": "Mr. Snuggles floats contentedly, trusting the group."
	},
	"case_file": {
		"tank_hover": "PIG'S BORING PAPERS",
		"tank_inspect": "Pig's always writing stuff! NERD!",
		"reality_hover": "Navigation Notes",
		"reality_inspect": "Pig's case file with dates, routes, and star charts."
	}
}

# Rhythm game tracking
var oar_strokes: int = 0
var correct_rhythm_count: int = 0

# Echo game tracking
var echo_clicks: Array = []
var correct_echo_direction: String = "east"


func _on_room_entered() -> void:
	if state.visited_before:
		return

	state.visited_before = true

	# Atmospheric intro - midnight, fog, quiet
	await E.queue([
		"*Day 3 on the raft*",
		"*Midnight*",
		"*The fog rolls in thick*",
	])

	await G.wait(1.0)

	await E.queue([
		"Pig: *writing in case file*",
		"Pig: 'Day three. Fog heavy. Can't see nothin'.'",
		"Tank: ...it's very quiet.",
		"Mr. Snuggles: *ears swivel, listening*",
	])

	await G.wait(0.5)

	await E.queue([
		"Pig: We need to find land before supplies run out.",
		"Pig: *checks route sketch*",
		"Pig: Puerto Rico should be close. But which way?",
	])

	# Check if player has shell whistle from Room 11
	if I.ShellWhistle.is_in_inventory():
		await E.queue([
			"*You have the Shell Whistle. It might help with echoes.*",
		])


func _on_room_transition_started() -> void:
	pass


func trigger_navigation_puzzle() -> void:
	"""Start the fog navigation dialog."""
	D.FogNavigation.start()


func execute_brains_sound_solution() -> void:
	"""Brains solution 1: Follow gull sounds with oar rhythm."""
	state.navigation_solved = true
	state.solution_used = "sound"

	GameState.solve_puzzle("fog_navigation", GameState.Approach.BRAINS)

	await E.queue([
		"Pig: Wait... y'hear that?",
		"*Distant seabird calls*",
		"Pig: Birds! Land's gotta be that direction!",
	])

	# Rhythm mini-game narrative
	await E.queue([
		"Tank: I'LL ROW US THERE!",
		"Pig: Match the rhythm of the waves or we'll spin.",
		"Tank: *focuses intensely*",
	])

	await _perform_oar_rhythm()

	await E.queue([
		"*The raft glides smoothly through the fog*",
		"*The bird calls grow louder*",
		"Pig: We're gettin' close!",
	])

	_collect_standard_items()
	_approach_land()


func execute_brains_star_solution() -> void:
	"""Brains solution 2: Reality Vision star navigation."""
	state.navigation_solved = true
	state.solution_used = "stars"

	GameState.solve_puzzle("fog_navigation", GameState.Approach.BRAINS)

	await E.queue([
		"Pig: *looks up*",
		"Pig: The fog's thinner up high. I can see stars.",
		"Tank: So? They're just dots!",
		"Pig: *pulls out route sketch*",
	])

	# Star alignment puzzle
	await E.queue([
		"*Pig compares the constellation to the route sketch*",
		"Pig: There! That cluster points southeast.",
		"Pig: Puerto Rico should be that way.",
		"Tank: ...you can READ the sky?!",
		"Pig: It's called navigation, Tank.",
	])

	await E.queue([
		"*Following the stars, the raft finds its heading*",
		"Mr. Snuggles: *nods approvingly at Pig's intelligence*",
	])

	_collect_standard_items()
	I.DriftBottleNote.add()  # Bonus for smart solution
	_approach_land()


func execute_bizarre_solution() -> void:
	"""Bizarre solution: LAND AHOY echo trick."""
	state.navigation_solved = true
	state.solution_used = "echo"

	GameState.solve_puzzle("fog_navigation", GameState.Approach.BIZARRE)

	await E.queue([
		"Tank: I HAVE AN IDEA!",
		"Pig: Oh no.",
		"Tank: *stands up dramatically*",
		"Pig: Tank, don't-",
	])

	# Echo game
	await E.queue([
		"Tank: LAAAAAND AHOOOOOOY!!!",
		"*The shout echoes into the fog*",
		"*...*",
		"*Faint echo returns from the east*",
	])

	await E.queue([
		"Tank: *cups ear*",
		"Tank: I heard it! THAT WAY!",
		"Pig: ...did you just use echolocation?",
		"Tank: I used YELLING!",
	])

	# Shell whistle bonus
	if I.ShellWhistle.is_in_inventory():
		await E.queue([
			"Tank: *blows shell whistle*",
			"*HOOOOONK*",
			"*Stronger echo returns*",
			"Tank: CONFIRMED!",
			"Pig: *reluctantly impressed*",
		])
		GameState.modify_morale(5)

	await E.queue([
		"*Against all logic, the echo leads to land*",
		"*Achievement: Master of the Ancient Art of Yelling*",
	])

	_collect_standard_items()
	_approach_land()


func execute_fail_forward() -> void:
	"""Fail-forward: Wrong direction, bump sandbar, still arrive."""
	state.navigation_solved = true
	state.solution_used = "fail_forward"
	state.hit_sandbar = true

	await E.queue([
		"Tank: *paddles confidently*",
		"Tank: I KNOW it's THIS way!",
		"Pig: Tank, are you sure-",
		"Tank: TRUST ME!",
	])

	await E.queue([
		"*The raft drifts into the fog*",
		"*...*",
		"*CRUNCH*",
		"Tank: ?!",
	])

	# Sandbar hit
	await E.queue([
		"*The raft hits a sandbar and spins*",
		"*Everyone tumbles*",
		"Mr. Snuggles: *floats calmly upside down for a moment*",
		"Tank: WHOOPS!",
		"Pig: *muffled frustration*",
	])

	await E.queue([
		"*After untangling, the current carries you toward land*",
		"*Different beach than planned, but still Puerto Rico*",
		"Pig: Well... we got here. Somehow.",
		"*Different route = different loot at destination*",
	])

	state.alternate_beach = true
	_collect_fail_items()
	_approach_land()


func _perform_oar_rhythm() -> void:
	"""Narrative for the oar rhythm sequence."""
	# In a full implementation, this would be an actual minigame
	# For now, it's a narrative beat
	await E.queue([
		"*Stroke... stroke... stroke...*",
		"*Tank matches the rhythm of the waves*",
		"*Stroke... stroke... stroke...*",
		"Pig: You're doin' great! Keep it steady!",
	])


func _collect_standard_items() -> void:
	"""Give items for successful navigation."""
	if not state.collected_rope:
		state.collected_rope = true
		I.MoistRope.add()
		await E.queue([
			"*Found: Moist Rope (soaked but still useful)*",
		])


func _collect_fail_items() -> void:
	"""Give different items for fail-forward path."""
	if not state.collected_rope:
		state.collected_rope = true
		I.MoistRope.add()
		await E.queue([
			"*Found: Moist Rope (extra soggy from the tumble)*",
		])


func _approach_land() -> void:
	"""Final approach to Puerto Rico."""
	await E.queue([
		"*The fog begins to thin*",
		"*A dark shape emerges ahead*",
	])

	await G.wait(1.0)

	await E.queue([
		"Tank: Is that...?",
		"Pig: *squints*",
		"Mr. Snuggles: *ears perk forward*",
	])

	await G.wait(0.5)

	await E.queue([
		"Tank: LAND!",
		"Pig: That's Puerto Rico! We made it!",
		"Tank: LAND! AHOY! FOR REAL THIS TIME!",
	])

	# Transition message
	await E.queue([
		"*The raft drifts toward shore*",
		"*After three days at sea, solid ground awaits*",
		"Pig: *closes case file*",
		"Pig: 'Day three, midnight. Puerto Rico. We made it.'",
	])

	# Go to next room
	E.goto_room("PuertoRico")


func check_case_file() -> void:
	"""Player examines Pig's case file."""
	await E.queue([
		"*Pig's Case File - Navigation Notes*",
		"",
		"Day 1: Left Brazil. Weather clear.",
		"Day 2: Current steady. Tank ate half the food.",
		"Day 3: Fog. Can't see. Writing by feel.",
		"",
		"Route: Brazil -> Puerto Rico -> Florida -> ???",
		"",
		"*Star chart sketched in margin*",
	])

	if TankVision.is_reality_mode:
		await E.queue([
			"*The star chart shows a bright cluster pointing southeast*",
			"*That's the way to Puerto Rico*",
		])
	else:
		await E.queue([
			"*The star chart looks like random dots*",
			"*Pig sure is good at drawing circles!*",
		])


func listen_for_sounds() -> void:
	"""Player tries to hear land."""
	if state.navigation_solved:
		await C.Tank.say("We already found the way!")
		return

	await E.queue([
		"*You listen carefully...*",
	])

	await G.wait(1.0)

	if TankVision.is_reality_mode:
		await E.queue([
			"*Waves lapping against the raft*",
			"*Wind across the water*",
			"*And... faint bird calls to the east*",
		])
	else:
		await E.queue([
			"*MYSTERIOUS OCEAN NOISES*",
			"*Could be anything! Probably DANGER!*",
			"Tank: The sea is full of SECRETS!",
		])


func shout_into_fog() -> void:
	"""Tank yells and listens for echoes."""
	if state.navigation_solved:
		await C.Tank.say("We already found the way!")
		return

	await E.queue([
		"Tank: *takes deep breath*",
		"Tank: HELLOOOOOO!",
	])

	await G.wait(1.5)

	await E.queue([
		"*Faint echo from the east: '...ellooo...'*",
		"Tank: Something answered!",
		"Pig: That's... that's an echo, Tank.",
		"Tank: GHOST ANSWERS!",
	])

	state.heard_echo = true
