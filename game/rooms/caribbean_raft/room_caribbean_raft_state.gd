extends PopochiuRoomData

## State for Room 12 - Caribbean Raft: Midnight Fog

var navigation_solved: bool = false
var solution_used: String = ""  # "sound", "stars", "echo", "fail_forward"
var collected_rope: bool = false
var heard_echo: bool = false
var hit_sandbar: bool = false
var alternate_beach: bool = false  # Different loot at Puerto Rico if true


#region Virtual ####################################################################################
func _on_save() -> Dictionary:
	return {
		"navigation_solved": navigation_solved,
		"solution_used": solution_used,
		"collected_rope": collected_rope,
		"heard_echo": heard_echo,
		"hit_sandbar": hit_sandbar,
		"alternate_beach": alternate_beach
	}


func _on_load(data: Dictionary) -> void:
	navigation_solved = data.get("navigation_solved", false)
	solution_used = data.get("solution_used", "")
	collected_rope = data.get("collected_rope", false)
	heard_echo = data.get("heard_echo", false)
	hit_sandbar = data.get("hit_sandbar", false)
	alternate_beach = data.get("alternate_beach", false)


#endregion
