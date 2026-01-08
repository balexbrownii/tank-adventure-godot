extends Node2D
## Brazil Village - Second room in Tank's Great Adventure
##
## The village has a trader who will exchange the exotic flower for rope.

const ROOM_ID := "brazil_village"


func _ready() -> void:
	print("[BrazilVillage] Room loaded!")

	if not GameManager.has_flag("visited_brazil_village"):
		GameManager.set_flag("visited_brazil_village", true)
		await get_tree().create_timer(0.5).timeout
		GameManager.show_message("Tank emerges from the forest into a small village.")
