extends PopochiuRoomData

## Room 15 - Luggage Room state tracking

## Puzzle A: Find Texas Suitcase
var found_texas_suitcase: bool = false
var solution_tag: String = ""  # "text_puzzle", "craft", "force"
var wrong_suitcase: bool = false  # Fail-forward triggered

## Puzzle B: Keep Party Together
var party_linked: bool = false
var solution_link: String = ""  # "rope", "sound", "force"
var lost_deer_temporarily: bool = false  # Fail-forward triggered

## Overall completion
var room_complete: bool = false


#region Virtual ####################################################################################
func _on_save() -> Dictionary:
	return {
		"found_texas_suitcase": found_texas_suitcase,
		"solution_tag": solution_tag,
		"wrong_suitcase": wrong_suitcase,
		"party_linked": party_linked,
		"solution_link": solution_link,
		"lost_deer_temporarily": lost_deer_temporarily,
		"room_complete": room_complete
	}


func _on_load(data: Dictionary) -> void:
	found_texas_suitcase = data.get("found_texas_suitcase", false)
	solution_tag = data.get("solution_tag", "")
	wrong_suitcase = data.get("wrong_suitcase", false)
	party_linked = data.get("party_linked", false)
	solution_link = data.get("solution_link", "")
	lost_deer_temporarily = data.get("lost_deer_temporarily", false)
	room_complete = data.get("room_complete", false)


#endregion
