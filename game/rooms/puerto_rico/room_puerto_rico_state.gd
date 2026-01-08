extends PopochiuRoomData

## State for Room 13 - Puerto Rico: Motel + Back Dock


# Puzzle A: Get Room
var got_room: bool = false
var room_solution: String = ""  # "trade", "charm", "intimidate", "fail"
var slept_outside: bool = false
var cranky_pig: bool = false  # Hints cost double if true

# Puzzle B: Get Boat
var got_boat: bool = false
var boat_solution: String = ""  # "permission", "lift", "teamwork"

# Misc state
var knows_camera_fake: bool = false
var used_vending: bool = false


#region Virtual ####################################################################################
func _on_save() -> Dictionary:
	return {
		"got_room": got_room,
		"room_solution": room_solution,
		"slept_outside": slept_outside,
		"cranky_pig": cranky_pig,
		"got_boat": got_boat,
		"boat_solution": boat_solution,
		"knows_camera_fake": knows_camera_fake,
		"used_vending": used_vending
	}


func _on_load(data: Dictionary) -> void:
	got_room = data.get("got_room", false)
	room_solution = data.get("room_solution", "")
	slept_outside = data.get("slept_outside", false)
	cranky_pig = data.get("cranky_pig", false)
	got_boat = data.get("got_boat", false)
	boat_solution = data.get("boat_solution", "")
	knows_camera_fake = data.get("knows_camera_fake", false)
	used_vending = data.get("used_vending", false)


#endregion
