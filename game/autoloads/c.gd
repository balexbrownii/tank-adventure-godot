@tool
extends "res://addons/popochiu/engine/interfaces/i_character.gd"

# classes ----
const PCTank := preload("res://game/characters/tank/character_tank.gd")
const PCPig := preload("res://game/characters/pig/character_pig.gd")
const PCMrSnuggles := preload("res://game/characters/mr_snuggles/character_mr_snuggles.gd")
# ---- classes

# nodes ----
var Tank: PCTank : get = get_Tank
var Pig: PCPig : get = get_Pig
var MrSnuggles: PCMrSnuggles : get = get_MrSnuggles
# ---- nodes

# functions ----
func get_Tank() -> PCTank: return get_runtime_character("Tank")
func get_Pig() -> PCPig: return get_runtime_character("Pig")
func get_MrSnuggles() -> PCMrSnuggles: return get_runtime_character("MrSnuggles")
# ---- functions

