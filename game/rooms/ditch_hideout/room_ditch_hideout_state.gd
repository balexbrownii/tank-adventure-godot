extends PopochiuRoomData
## State persistence for Room 3 - Ditch Hideout

# Room progression
var wolf_left: bool = false

# Camp setup
var camp_made: bool = false
var solution_used: String = ""  # "standard", "brains", "brawn", "fail_forward"

# Item flags
var has_leaf_blanket: bool = false
var has_leaf_wrap: bool = false
var punched_ground: bool = false
var no_blanket: bool = false

# Item collection
var took_leaves: bool = false
var took_roots: bool = false
var took_charcoal: bool = false

# Story state for Room 4 setup
var leg_under_leaves: bool = false
var invented_injury: bool = false
