@tool
extends PopochiuRoom
## Room 5 - Poison Picnic (Ignorance Tutorial)
## Tank eats poisonous mushrooms and survives because she doesn't know it's poisonous.
## THIS TEACHES THE IGNORANCE MECHANIC - Tank's obliviousness is an advantage!

const Data := preload('room_poison_picnic_state.gd')
var state: Data = load("res://game/rooms/poison_picnic/room_poison_picnic.tres")

# Tank Vision labels - ignorance matters here!
var vision_data: Dictionary = {
	"rock_seat": {
		"tank_hover": "PICNIC THRONE",
		"tank_inspect": "A perfect seat for a warrior's breakfast! The rock welcomes me!",
		"reality_hover": "Large Flat Rock",
		"reality_inspect": "A flat rock. Good place to sit and eat."
	},
	"backpack_food": {
		"tank_hover": "ADVENTURE SNACKS",
		"tank_inspect": "Mushrooms and bark! Nature provides for its champions!",
		"reality_hover": "Backpack Contents",
		"reality_inspect": "Some mushrooms and bark... wait, those mushrooms look unusual."
	},
	"sap_smear": {
		"tank_hover": "FLAVOR SAUCE",
		"tank_inspect": "Ooh, natural syrup! This will make everything taste better!",
		"reality_hover": "Tree Sap (suspicious)",
		"reality_inspect": "That sap is from a toxicwood tree. It causes severe stomach cramps."
	},
	"trail_fork": {
		"tank_hover": "PATH OF DESTINY",
		"tank_inspect": "Two paths diverge! Both lead to GLORY!",
		"reality_hover": "Trail Fork",
		"reality_inspect": "The trail splits here. One path goes toward the road."
	},
	"birds_overhead": {
		"tank_hover": "SKY COMPANIONS",
		"tank_inspect": "Birds! They sing songs of my victories!",
		"reality_hover": "Circling Birds",
		"reality_inspect": "Those birds are circling something... or waiting for something to die."
	}
}


func _on_room_entered() -> void:
	if state.visited_before:
		return

	state.visited_before = true

	# Check for Miracle Confidence from Room 4
	var has_miracle_confidence = GameState.has_temporary_status("miracle_confidence")

	# Intro sequence
	await E.queue([
		"*Tank settles onto a flat rock*",
		"Tank: Time for breakfast!",
	])

	if has_miracle_confidence:
		await C.Tank.say("I feel INVINCIBLE after this morning's miracle!")

	await E.queue([
		"Tank: *rummages in backpack*",
		"Tank: Let's see what supplies we have...",
	])


func _on_room_transition_started() -> void:
	pass


func execute_ignorance_solution() -> void:
	"""Ignorance solution: Eat without examining. Tank survives through sheer obliviousness."""
	state.food_eaten = true
	state.solution_used = "ignorance"
	state.ignorance_preserved = true

	# This is the "correct" funny solution - Tank's ignorance protects her
	GameState.solve_puzzle("picnic_food", GameState.Approach.BRAWN)  # Brawn fits "just do it"

	await E.queue([
		"Tank: *grabs mushrooms*",
		"Tank: These look DELICIOUS!",
		"Tank: *takes a big bite*",
		"Tank: Mmm! Earthy!",
	])

	# Pick up sap-coated bark
	await E.queue([
		"Tank: *dips bark in sap*",
		"Tank: And some FLAVOR SAUCE!",
		"Tank: *crunch crunch*",
		"Tank: Perfect warrior breakfast!",
	])

	# Tank is FINE because she doesn't know it's poisonous
	await E.queue([
		"*You ate the mushrooms and bark with no ill effects*",
		"*Tank's ignorance protected her - she didn't know it was poisonous*",
		"*Ignorance meter stays low - this is GOOD*",
	])

	# Add items to inventory (partially eaten versions)
	I.PoisonMushrooms.add()
	I.SapBark.add()


func execute_brains_solution() -> void:
	"""Brains solution: Examine in Reality Vision, discover poison."""
	state.discovered_poison = true
	state.solution_used = "brains"

	GameState.solve_puzzle("picnic_food", GameState.Approach.BRAINS)

	# Examining reveals the truth - but there's a cost
	await E.queue([
		"Tank: Wait... let me look at this more carefully...",
		"*In Reality Vision, you notice warning signs*",
		"Tank: These mushrooms have... skull-shaped spots?",
		"Tank: And that sap smells like... death?",
	])

	# Ignorance goes UP (Tank learned something)
	GameState.add_ignorance(1)

	await E.queue([
		"*IGNORANCE +1*",
		"*Tank now knows about poison. She's lost some of her protective obliviousness.*",
		"*Future 'dumb luck' options may no longer be available.*",
	])

	# Player can still choose to eat or not
	D.EatAnyway.start()


func execute_bizarre_solution() -> void:
	"""Bizarre solution: Don't eat, save food as bait for later."""
	state.saved_as_bait = true
	state.solution_used = "bizarre"

	GameState.solve_puzzle("picnic_food", GameState.Approach.BIZARRE)

	await E.queue([
		"Tank: Hmm... I have a BRILLIANT idea!",
		"Tank: What if I SAVE this food...",
		"Tank: To use as BAIT for enemies?!",
	])

	# Add items as "bait" versions
	I.PoisonMushrooms.add()
	I.SapBark.add()

	await E.queue([
		"*Gained: Poison Mushrooms (bait)*",
		"*Gained: Sap Bark (bait)*",
		"*These can be used strategically in future rooms*",
		"Tank: A hungry warrior is a MOTIVATED warrior!",
	])

	# Harder next room but more options
	state.hungry_debuff = true


func execute_fail_forward() -> void:
	"""Fail-forward: Tank eats AND knows it's poison. Gets sick."""
	state.food_eaten = true
	state.got_sick = true
	state.solution_used = "fail_forward"

	await E.queue([
		"Tank: *eats food*",
		"Tank: That tasted a bit... off...",
		"Tank: *clutches stomach*",
		"Tank: I'M DYING!!! THE POISON HAS TAKEN ME!!!",
	])

	# Dramatic sick performance
	await E.queue([
		"*Tank staggers around dramatically*",
		"Tank: AVENGE ME! TELL MY STORY!",
		"Tank: *pause*",
		"Tank: Wait... I'm... still alive?",
		"Tank: It must be because I am SO STRONG!",
	])

	# Quick micro-puzzle
	await E.queue([
		"*Tank needs to find water and sit down*",
		"*The stomach cramps will pass*",
	])

	# Add sick status temporarily
	GameState.add_temporary_status("sick_stomach")
	GameState.add_ignorance(1)  # Tank learned poison exists


func trigger_food_choice() -> void:
	"""Start the food choice dialog."""
	D.FoodChoice.start()


func tell_tank_about_poison() -> void:
	"""Tell Tank" mechanic - permanently changes her awareness."""
	if state.told_tank:
		await C.Tank.say("I already know about poison now...")
		return

	state.told_tank = true
	GameState.add_ignorance(2)  # Big increase for explicit teaching

	await E.queue([
		"Tank: Wait... you're saying that food is... POISONOUS?",
		"Tank: But... it looked so tasty...",
		"Tank: *deep concern*",
		"Tank: How do I know what's safe to eat now?!",
	])

	await E.queue([
		"*IGNORANCE +2*",
		"*Tank's protective obliviousness is significantly reduced*",
		"*Some 'dumb luck' options will no longer work*",
		"*Future poison hazards will harm Tank*",
	])


func take_rock_chalk() -> void:
	"""Take optional rock chalk for writing signs later."""
	if state.took_chalk:
		await C.Tank.say("I already grabbed some chalk.")
		return

	state.took_chalk = true
	I.RockChalk.add()

	await E.queue([
		"Tank: *scrapes chalky rock*",
		"Tank: This could be useful for writing messages!",
		"Tank: 'TANK WAS HERE'!",
	])
