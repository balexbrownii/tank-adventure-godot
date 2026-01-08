extends Node2D
## Brazil Forest - Starting room for Tank's Great Adventure
##
## This is the first room where Tank and her companions arrive in the Brazilian
## rainforest. Interactive elements include: tree stump with machete, exotic flower,
## and vines blocking the path to the village.

# Room state
var machete_taken := false
var flower_taken := false
var vines_cut := false


func _ready() -> void:
	# Called when the room is loaded
	print("Brazil Forest room loaded!")

	# Show intro message on first visit
	# TODO: Integrate with Popochiu's dialog system
	await get_tree().create_timer(0.5).timeout
	print("Tank finds herself in a lush Brazilian rainforest.")
	print("Her companions Pig and Mr. Snuggles look around nervously.")


func _on_room_entered() -> void:
	# Called when transitioning to this room
	pass


func _on_room_exited() -> void:
	# Called when leaving this room
	pass
