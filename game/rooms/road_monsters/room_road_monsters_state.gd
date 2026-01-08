extends PopochiuRoomData
## Room state for Road of Monsters + Gas Station (Room 6)
## Tracks puzzle progress, which solution was used, and item gains.

## Which approach was used to solve the main puzzle
## "", "brawn", "brains", "bizarre"
var solution_used: String = ""

## Whether the explosion has been triggered (inevitable but timing varies)
var explosion_triggered: bool = false

## Whether police have arrived
var police_arrived: bool = false

## Items that have been picked up in this room
var items_collected: Array[String] = []

## Whether Tank has examined the cars in Reality Vision
var cars_examined_reality: bool = false

## Whether the fail-forward sequence was triggered
var fail_forward_triggered: bool = false


#region Virtual ####################################################################################
func _on_save() -> Dictionary:
	return {
		"solution_used": solution_used,
		"explosion_triggered": explosion_triggered,
		"police_arrived": police_arrived,
		"items_collected": items_collected,
		"cars_examined_reality": cars_examined_reality,
		"fail_forward_triggered": fail_forward_triggered
	}


func _on_load(data: Dictionary) -> void:
	solution_used = data.get("solution_used", "")
	explosion_triggered = data.get("explosion_triggered", false)
	police_arrived = data.get("police_arrived", false)
	items_collected = data.get("items_collected", [])
	cars_examined_reality = data.get("cars_examined_reality", false)
	fail_forward_triggered = data.get("fail_forward_triggered", false)


#endregion
