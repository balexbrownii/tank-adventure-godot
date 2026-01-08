@tool
extends PopochiuRoom
## Room 9 - Pig + Deer Crossing
## Tank almost hits Pig (riding Mr. Snuggles the deer).
## This is where the party system is introduced.

const Data := preload('room_pig_deer_crossing_state.gd')
var state: Data = load("res://game/rooms/pig_deer_crossing/room_pig_deer_crossing.tres")

## Vision data for hotspots in this room
var vision_data: Dictionary = {
	"pig": {
		"tank_hover": "ANGRY BACON",
		"tank_inspect": "A very angry... bacon? No wait, it's wearing pants!",
		"reality_hover": "Pig",
		"reality_inspect": "A pig in workout pants. Looks furious. And... strangely eloquent?"
	},
	"deer": {
		"tank_hover": "FLUFFY HORSE",
		"tank_inspect": "The fluffiest horse I've ever seen! So calm!",
		"reality_hover": "Mr. Snuggles (Deer)",
		"reality_inspect": "A remarkably calm deer. It's wearing a tiny saddle."
	},
	"road": {
		"tank_hover": "MONSTER PATH",
		"tank_inspect": "The path the monsters travel. I should be careful.",
		"reality_hover": "Road",
		"reality_inspect": "A dusty road. You nearly caused an accident here."
	},
	"motorcycle": {
		"tank_hover": "MY METAL HORSE",
		"tank_inspect": "My trusty metal horse! Still smoking a bit.",
		"reality_hover": "Motorcycle",
		"reality_inspect": "Your motorcycle. Skid marks show where you stopped suddenly."
	},
	"supplies_pouch": {
		"tank_hover": "TREASURE BAG",
		"tank_inspect": "That bag looks full of treasures! Or snacks!",
		"reality_hover": "Pig's Supplies",
		"reality_inspect": "A well-organized travel pouch. This pig is prepared."
	},
	"oak_tree": {
		"tank_hover": "BIG TREE FRIEND",
		"tank_inspect": "A friendly tree in the distance! It waves at me!",
		"reality_hover": "Oak Tree (Distance)",
		"reality_inspect": "A large oak tree. Could make a good camp spot."
	}
}


#region Virtual ####################################################################################
func _on_room_entered() -> void:
	# Register vision data for this room
	for hotspot_id in vision_data:
		TankVision.register_hotspot_data("PigDeerCrossing", hotspot_id, vision_data[hotspot_id])


func _on_room_transition_finished() -> void:
	if not state.intro_complete:
		await _play_intro_sequence()
		state.intro_complete = true


#endregion

#region Public ####################################################################################

## Execute Brains solution: Apologize and offer help
func execute_brains_solution() -> void:
	state.solution_used = "brains"
	GameState.solve_puzzle("pig_recruitment", GameState.Approach.BRAINS)
	GameState.modify_morale(10)

	await E.queue([
		"Tank: I'm really sorry! I didn't see you there!",
		"Pig: *snort* Well at least you're honest about it.",
		"Tank: Can I help you somehow? Make it up to you?",
		"Pig: Hmm... You got manners. That's rare these days.",
		"Pig adjusts his workout pants",
		"Pig: Alright partner, where you headed?",
		"Tank: Canada! To find... something important!",
		"Pig: Canada?! Well shoot, that's where WE'RE headed too!",
		"Pig: Name's Pig. This here's Mr. Snuggles.",
		"Mr. Snuggles nods serenely",
		"Tank: I'm Tank! Want to travel together?",
		"Pig: You know what? I think we just might."
	])

	await _complete_recruitment()


## Execute Bizarre solution: Bribe with donuts
func execute_bizarre_solution() -> void:
	state.solution_used = "bizarre"
	GameState.solve_puzzle("pig_recruitment", GameState.Approach.BIZARRE)
	# Morale neutral

	await E.queue([
		"Tank: Wait! I have DONUTS!",
		"Tank holds up the donut box like a peace offering",
		"Pig: ...",
		"Pig: Are you trying to BRIBE me?",
		"Tank: Is it working?",
		"Pig stares at the donuts",
		"Pig: ...Yes. Yes it is.",
		"Pig: You're not too bright, are ya?",
		"Tank: I've been told that!",
		"Pig: *sigh* Name's Pig. The deer's Mr. Snuggles.",
		"Pig: We're headed to Canada. You?",
		"Tank: ALSO CANADA!",
		"Pig: Of course you are. Fine, we'll travel together.",
		"Pig: But I'm keeping these donuts."
	])

	# Remove the DonutBox
	if I.DonutBox.is_in_inventory():
		I.DonutBox.queue_remove()

	await _complete_recruitment()


## Execute Brawn solution: Intimidation
func execute_brawn_solution() -> void:
	state.solution_used = "brawn"
	GameState.solve_puzzle("pig_recruitment", GameState.Approach.BRAWN)
	GameState.modify_morale(-10)

	await E.queue([
		"Tank flexes dramatically",
		"Tank: MOVE! I'M IN A HURRY!",
		"Pig: Did you just... flex at me?",
		"Tank: I AM VERY STRONG!",
		"Pig: I can SEE that!",
		"Mr. Snuggles remains completely unbothered",
		"Pig: You know what? Fine. FINE.",
		"Pig: We're going to Canada anyway.",
		"Pig: Might as well travel with the muscle-brained lunatic.",
		"Tank: YAY! I'M THE LEADER!",
		"Pig: You are absolutely NOT the leader.",
		"Tank: ...Co-leader?",
		"Pig: We'll discuss this later."
	])

	# Unlock special dialogue option
	GameState.set_flag("tank_declared_leader", true)

	await _complete_recruitment()


## Execute fail-forward: Strap fix task
func execute_fail_forward() -> void:
	state.strap_task_given = true

	await E.queue([
		"Pig: You know what? Prove you're useful.",
		"Pig: Mr. Snuggles' saddle strap is loose.",
		"Pig: Fix it, and MAYBE we can talk.",
		"Tank: I can do that!",
		"Tank: ...How do I do that?"
	])

	# Player needs to interact with the deer to fix the strap


## Complete the strap fix task
func complete_strap_fix() -> void:
	state.strap_fixed = true

	await E.queue([
		"Tank fiddles with the strap",
		"Tank: Like this?",
		"Pig: No, the other- actually, that works.",
		"Pig: Huh. You're handier than you look.",
		"Tank: I'm VERY handy!",
		"Pig: Alright, you've earned a conversation.",
		"Pig: Name's Pig. Where you headed?"
	])

	# Now show the normal recruitment options
	await D.PigRecruitment.start()


#endregion

#region Private ####################################################################################

func _play_intro_sequence() -> void:
	await E.queue([
		"Tank roars down the road on the motorcycle",
		"Tank: WHEEEEE!",
		"...",
		"Tank: Wait, what's that in the road?!",
		"SCREEEECH!",
		"The motorcycle skids to a halt inches from a pig riding a deer"
	])

	# Different reaction based on previous choices
	if I.PlushStuck.is_in_inventory():
		await E.queue([
			"Pig: WHAT IN TARNATION?!",
			"Pig: You nearly ran us over! And why do you have a PLUSHIE stuck to your back?!",
			"Tank: It's a long story!"
		])
	else:
		await E.queue([
			"Pig: WHAT IN TARNATION?!",
			"Pig: You nearly KILLED us!",
			"Tank: Sorry! The metal horse is hard to control!"
		])

	await E.queue([
		"Pig: 'Metal horse'?! It's a MOTORCYCLE!",
		"The deer - somehow - remains perfectly calm",
		"Pig: Mr. Snuggles here almost had a heart attack!",
		"Mr. Snuggles blinks peacefully",
		"Pig: Okay, maybe not. But I DID!"
	])

	state.pig_mood = "angry"


func _complete_recruitment() -> void:
	state.pig_joined = true

	# Add party members to GameState
	GameState.add_party_member("Pig")
	GameState.add_party_member("MrSnuggles")

	# Give Pig's Craft Kit
	I.CraftKit.queue_add()

	# Give food items
	I.MiniDonuts.queue_add()
	I.SpinachLeaves.queue_add()

	await E.queue([
		"Pig: Here, take some supplies.",
		"Pig hands over mini donuts and spinach leaves",
		"Pig: And this here's my craft kit. Might come in handy.",
		"Tank: What's it do?",
		"Pig: Lets you combine things. Make new stuff.",
		"Tank: AMAZING!",
		"Pig: It's just basic crafting...",
		"Tank: A-MA-ZING!"
	])

	# Tutorial for party switching
	await E.queue([
		"Pig: Now, we're a team. That means we can work together.",
		"Pig: Sometimes you might need MY skills instead of yours.",
		"Pig: Or Mr. Snuggles' skills. He's sneakier than he looks.",
		"Mr. Snuggles somehow looks proud",
		"Tank: How do I switch who's doing things?",
		"Pig: Just focus on who you want to take the lead.",
		"Pig: I'll handle the thinking. You handle the punching.",
		"Tank: I'M GREAT AT PUNCHING!"
	])

	# Point toward next area
	await E.queue([
		"Pig: See that oak tree over yonder?",
		"Pig: Good spot to make camp and plan our route.",
		"Tank: TO THE TREE!"
	])

	# Transition to next room
	E.goto_room("OakTreeCamp")


#endregion
