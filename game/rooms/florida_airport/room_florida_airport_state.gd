extends PopochiuRoomData

## State for Room 14 - Florida Airport Entrance

var entered_airport: bool = false
var entry_solution: String = ""  # "disguise", "distraction", "support_deer", "fail_forward"
var went_through_gift_shop: bool = false


#region Virtual ####################################################################################
func _on_save() -> Dictionary:
	return {
		"entered_airport": entered_airport,
		"entry_solution": entry_solution,
		"went_through_gift_shop": went_through_gift_shop
	}


func _on_load(data: Dictionary) -> void:
	entered_airport = data.get("entered_airport", false)
	entry_solution = data.get("entry_solution", "")
	went_through_gift_shop = data.get("went_through_gift_shop", false)


#endregion
