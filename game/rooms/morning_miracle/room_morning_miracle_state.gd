extends PopochiuRoomData
## State persistence for Room 4 - Morning Miracle

# Room progression

# Puzzle state
var leg_revealed: bool = false
var leg_awakened: bool = false
var solution_used: String = ""  # "brains", "brawn", "bizarre", "fail_forward"

# Fail-forward flag
var refused_to_interact: bool = false
var pig_will_tease: bool = false

# Achievement
var achieved_miracle_screamer: bool = false
