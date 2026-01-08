@tool
class_name VisionHotspotData
extends Resource
## Resource that stores Tank Vision and Reality Vision labels for a hotspot.
## Attach to hotspots to define what Tank sees vs what's really there.

@export_group("Tank Vision")
## What Tank sees when hovering (typically CAPS, funny name)
@export var tank_hover: String = "MYSTERY THING"
## What Tank says when inspecting in Tank Vision
@export_multiline var tank_inspect: String = "I see... something."

@export_group("Reality Vision")
## What the thing actually is (lowercase, accurate)
@export var reality_hover: String = "Object"
## What the narrator/reality says when inspecting
@export_multiline var reality_inspect: String = "It's a thing."

@export_group("Tell Tank")
## Topic ID for "Tell Tank" system (if player can tell Tank the truth about this)
@export var tell_tank_topic: String = ""
## If true, "Tell Tank" option is available for this hotspot
@export var can_tell_tank: bool = false


## Get hover label for current vision mode
func get_hover(vision_mode: int) -> String:
	if vision_mode == TankVision.VisionMode.TANK:
		return tank_hover
	return reality_hover


## Get inspect text for current vision mode
func get_inspect(vision_mode: int) -> String:
	if vision_mode == TankVision.VisionMode.TANK:
		return tank_inspect
	return reality_inspect


## Convert to dictionary for the TankVision API
func to_dict() -> Dictionary:
	return {
		"tank_hover": tank_hover,
		"tank_inspect": tank_inspect,
		"reality_hover": reality_hover,
		"reality_inspect": reality_inspect,
		"tell_tank_topic": tell_tank_topic,
		"can_tell_tank": can_tell_tank
	}
