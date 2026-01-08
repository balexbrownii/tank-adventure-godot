extends PopochiuRoomData
## State persistence for Room 5 - Poison Picnic

# Room progression

# Puzzle state
var food_eaten: bool = false
var discovered_poison: bool = false
var saved_as_bait: bool = false
var got_sick: bool = false
var solution_used: String = ""  # "ignorance", "brains", "bizarre", "fail_forward"

# Ignorance mechanic
var ignorance_preserved: bool = false  # True if Tank stayed blissfully unaware
var told_tank: bool = false  # True if player used "Tell Tank" mechanic

# Debuffs
var hungry_debuff: bool = false  # True if didn't eat

# Item collection
var took_chalk: bool = false
