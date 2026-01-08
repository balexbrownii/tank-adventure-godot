@tool
extends "res://addons/popochiu/engine/interfaces/i_character.gd"

# classes ----
const PCTank := preload("res://game/characters/tank/character_tank.gd")
# ---- classes

# nodes ----
var Tank: PCTank : get = get_Tank
# ---- nodes

# functions ----
func get_Tank() -> PCTank: return get_runtime_character("Tank")
# ---- functions

