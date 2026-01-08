@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRBrazilForest := preload("res://game/rooms/brazil_forest/room_brazil_forest.gd")
const PRRoadMonsters := preload("res://game/rooms/road_monsters/room_road_monsters.gd")
const PRSpaceDrift := preload("res://game/rooms/space_drift/room_space_drift.gd")
const PRReentryFire := preload("res://game/rooms/reentry_fire/room_reentry_fire.gd")
const PRPigDeerCrossing := preload("res://game/rooms/pig_deer_crossing/room_pig_deer_crossing.gd")
const PROakTreeCamp := preload("res://game/rooms/oak_tree_camp/room_oak_tree_camp.gd")
const PRWantedCamp := preload("res://game/rooms/wanted_camp/room_wanted_camp.gd")
const PRWerewolfChase := preload("res://game/rooms/werewolf_chase/room_werewolf_chase.gd")
const PRDitchHideout := preload("res://game/rooms/ditch_hideout/room_ditch_hideout.gd")
const PRMorningMiracle := preload("res://game/rooms/morning_miracle/room_morning_miracle.gd")
const PRPoisonPicnic := preload("res://game/rooms/poison_picnic/room_poison_picnic.gd")
const PRBrazilEdgeBeach := preload("res://game/rooms/brazil_edge_beach/room_brazil_edge_beach.gd")
const PRCaribbeanRaft := preload("res://game/rooms/caribbean_raft/room_caribbean_raft.gd")
const PRPuertoRico := preload("res://game/rooms/puerto_rico/room_puerto_rico.gd")
const PRFloridaAirport := preload("res://game/rooms/florida_airport/room_florida_airport.gd")
const PRLuggageRoom := preload("res://game/rooms/luggage_room/room_luggage_room.gd")
const PRPlaneHold := preload("res://game/rooms/plane_hold/room_plane_hold.gd")
# ---- classes

# nodes ----
var BrazilForest: PRBrazilForest : get = get_BrazilForest
var RoadMonsters: PRRoadMonsters : get = get_RoadMonsters
var SpaceDrift: PRSpaceDrift : get = get_SpaceDrift
var ReentryFire: PRReentryFire : get = get_ReentryFire
var PigDeerCrossing: PRPigDeerCrossing : get = get_PigDeerCrossing
var OakTreeCamp: PROakTreeCamp : get = get_OakTreeCamp
var WantedCamp: PRWantedCamp : get = get_WantedCamp
var WerewolfChase: PRWerewolfChase : get = get_WerewolfChase
var DitchHideout: PRDitchHideout : get = get_DitchHideout
var MorningMiracle: PRMorningMiracle : get = get_MorningMiracle
var PoisonPicnic: PRPoisonPicnic : get = get_PoisonPicnic
var BrazilEdgeBeach: PRBrazilEdgeBeach : get = get_BrazilEdgeBeach
var CaribbeanRaft: PRCaribbeanRaft : get = get_CaribbeanRaft
var PuertoRico: PRPuertoRico : get = get_PuertoRico
var FloridaAirport: PRFloridaAirport : get = get_FloridaAirport
var LuggageRoom: PRLuggageRoom : get = get_LuggageRoom
var PlaneHold: PRPlaneHold : get = get_PlaneHold
# ---- nodes

# functions ----
func get_BrazilForest() -> PRBrazilForest: return get_runtime_room("BrazilForest")
func get_RoadMonsters() -> PRRoadMonsters: return get_runtime_room("RoadMonsters")
func get_SpaceDrift() -> PRSpaceDrift: return get_runtime_room("SpaceDrift")
func get_ReentryFire() -> PRReentryFire: return get_runtime_room("ReentryFire")
func get_PigDeerCrossing() -> PRPigDeerCrossing: return get_runtime_room("PigDeerCrossing")
func get_OakTreeCamp() -> PROakTreeCamp: return get_runtime_room("OakTreeCamp")
func get_WantedCamp() -> PRWantedCamp: return get_runtime_room("WantedCamp")
func get_WerewolfChase() -> PRWerewolfChase: return get_runtime_room("WerewolfChase")
func get_DitchHideout() -> PRDitchHideout: return get_runtime_room("DitchHideout")
func get_MorningMiracle() -> PRMorningMiracle: return get_runtime_room("MorningMiracle")
func get_PoisonPicnic() -> PRPoisonPicnic: return get_runtime_room("PoisonPicnic")
func get_BrazilEdgeBeach() -> PRBrazilEdgeBeach: return get_runtime_room("BrazilEdgeBeach")
func get_CaribbeanRaft() -> PRCaribbeanRaft: return get_runtime_room("CaribbeanRaft")
func get_PuertoRico() -> PRPuertoRico: return get_runtime_room("PuertoRico")
func get_FloridaAirport() -> PRFloridaAirport: return get_runtime_room("FloridaAirport")
func get_LuggageRoom() -> PRLuggageRoom: return get_runtime_room("LuggageRoom")
func get_PlaneHold() -> PRPlaneHold: return get_runtime_room("PlaneHold")
# ---- functions

