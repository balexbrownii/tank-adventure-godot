extends PopochiuRoomData

## Room 16 - Plane Hold state tracking (FINALE)

## Crash prep puzzle
var crash_prepped: bool = false
var prep_type: String = ""  # "full", "brawn", "calm", "panic"

## Outcomes
var items_saved: bool = false
var deer_secured: bool = false
var got_plastic_spoons: bool = false  # Fail-forward consolation

## Ending reached
var ending_reached: bool = false


#region Virtual ####################################################################################
func _on_save() -> Dictionary:
	return {
		"crash_prepped": crash_prepped,
		"prep_type": prep_type,
		"items_saved": items_saved,
		"deer_secured": deer_secured,
		"got_plastic_spoons": got_plastic_spoons,
		"ending_reached": ending_reached
	}


func _on_load(data: Dictionary) -> void:
	crash_prepped = data.get("crash_prepped", false)
	prep_type = data.get("prep_type", "")
	items_saved = data.get("items_saved", false)
	deer_secured = data.get("deer_secured", false)
	got_plastic_spoons = data.get("got_plastic_spoons", false)
	ending_reached = data.get("ending_reached", false)


#endregion
