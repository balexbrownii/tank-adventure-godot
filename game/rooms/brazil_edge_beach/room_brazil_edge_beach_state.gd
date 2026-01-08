extends PopochiuRoomData
## State persistence for Room 11 - Brazil Edge Beach

# Room progression

# Puzzle state
var jacket_crafted: bool = false
var jacket_overbuilt: bool = false  # True if Brawn solution used
var jacket_failed_test: bool = false  # True if fail-forward triggered
var solution_used: String = ""  # "brains", "brawn", "bizarre", "fail_forward"
var raft_launched: bool = false

# Item collection
var collected_rope: bool = false
var took_whistle: bool = false
