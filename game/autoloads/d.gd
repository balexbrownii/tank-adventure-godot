@tool
extends "res://addons/popochiu/engine/interfaces/i_dialog.gd"

# classes ----
const PDRoadMonstersApproach := preload("res://game/dialogs/road_monsters_approach/dialog_road_monsters_approach.gd")
const PDTakeCones := preload("res://game/dialogs/take_cones/dialog_take_cones.gd")
const PDTakeMapFlyer := preload("res://game/dialogs/take_map_flyer/dialog_take_map_flyer.gd")
const PDFireSpiritChoice := preload("res://game/dialogs/fire_spirit_choice/dialog_fire_spirit_choice.gd")
const PDAccidentChoice := preload("res://game/dialogs/accident_choice/dialog_accident_choice.gd")
const PDSpaceDriftApproach := preload("res://game/dialogs/space_drift_approach/dialog_space_drift_approach.gd")
const PDTakeDebris := preload("res://game/dialogs/take_debris/dialog_take_debris.gd")
const PDGravityPuzzleIntro := preload("res://game/dialogs/gravity_puzzle_intro/dialog_gravity_puzzle_intro.gd")
const PDMotorcycleApproach := preload("res://game/dialogs/motorcycle_approach/dialog_motorcycle_approach.gd")
const PDTakeSignArrow := preload("res://game/dialogs/take_sign_arrow/dialog_take_sign_arrow.gd")
const PDTakeDonutsReentry := preload("res://game/dialogs/take_donuts_reentry/dialog_take_donuts_reentry.gd")
const PDPigRecruitment := preload("res://game/dialogs/pig_recruitment/dialog_pig_recruitment.gd")
const PDFixStrap := preload("res://game/dialogs/fix_strap/dialog_fix_strap.gd")
const PDCampSafety := preload("res://game/dialogs/camp_safety/dialog_camp_safety.gd")
const PDPlanBoardIntro := preload("res://game/dialogs/plan_board_intro/dialog_plan_board_intro.gd")
const PDSoldierEncounter := preload("res://game/dialogs/soldier_encounter/dialog_soldier_encounter.gd")
const PDTakeBackpack := preload("res://game/dialogs/take_backpack/dialog_take_backpack.gd")
const PDTakeVine := preload("res://game/dialogs/take_vine/dialog_take_vine.gd")
const PDWerewolfChaseApproach := preload("res://game/dialogs/werewolf_chase_approach/dialog_werewolf_chase_approach.gd")
const PDTakeThorn := preload("res://game/dialogs/take_thorn/dialog_take_thorn.gd")
const PDMakeCamp := preload("res://game/dialogs/make_camp/dialog_make_camp.gd")
const PDTakeLeaves := preload("res://game/dialogs/take_leaves/dialog_take_leaves.gd")
const PDTakeRoots := preload("res://game/dialogs/take_roots/dialog_take_roots.gd")
const PDLegReveal := preload("res://game/dialogs/leg_reveal/dialog_leg_reveal.gd")
const PDFoodChoice := preload("res://game/dialogs/food_choice/dialog_food_choice.gd")
const PDEatAnyway := preload("res://game/dialogs/eat_anyway/dialog_eat_anyway.gd")
const PDLifeJacketBuild := preload("res://game/dialogs/life_jacket_build/dialog_life_jacket_build.gd")
const PDFogNavigation := preload("res://game/dialogs/fog_navigation/dialog_fog_navigation.gd")
const PDGetRoom := preload("res://game/dialogs/get_room/dialog_get_room.gd")
const PDGetBoat := preload("res://game/dialogs/get_boat/dialog_get_boat.gd")
const PDAirportEntry := preload("res://game/dialogs/airport_entry/dialog_airport_entry.gd")
const PDSuitcaseChoice := preload("res://game/dialogs/suitcase_choice/dialog_suitcase_choice.gd")
const PDKeepPartyTogether := preload("res://game/dialogs/keep_party_together/dialog_keep_party_together.gd")
const PDCrashPrep := preload("res://game/dialogs/crash_prep/dialog_crash_prep.gd")
# ---- classes

# nodes ----
var RoadMonstersApproach: PDRoadMonstersApproach : get = get_RoadMonstersApproach
var TakeCones: PDTakeCones : get = get_TakeCones
var TakeMapFlyer: PDTakeMapFlyer : get = get_TakeMapFlyer
var FireSpiritChoice: PDFireSpiritChoice : get = get_FireSpiritChoice
var AccidentChoice: PDAccidentChoice : get = get_AccidentChoice
var SpaceDriftApproach: PDSpaceDriftApproach : get = get_SpaceDriftApproach
var TakeDebris: PDTakeDebris : get = get_TakeDebris
var GravityPuzzleIntro: PDGravityPuzzleIntro : get = get_GravityPuzzleIntro
var MotorcycleApproach: PDMotorcycleApproach : get = get_MotorcycleApproach
var TakeSignArrow: PDTakeSignArrow : get = get_TakeSignArrow
var TakeDonutsReentry: PDTakeDonutsReentry : get = get_TakeDonutsReentry
var PigRecruitment: PDPigRecruitment : get = get_PigRecruitment
var FixStrap: PDFixStrap : get = get_FixStrap
var CampSafety: PDCampSafety : get = get_CampSafety
var PlanBoardIntro: PDPlanBoardIntro : get = get_PlanBoardIntro
var SoldierEncounter: PDSoldierEncounter : get = get_SoldierEncounter
var TakeBackpack: PDTakeBackpack : get = get_TakeBackpack
var TakeVine: PDTakeVine : get = get_TakeVine
var WerewolfChaseApproach: PDWerewolfChaseApproach : get = get_WerewolfChaseApproach
var TakeThorn: PDTakeThorn : get = get_TakeThorn
var MakeCamp: PDMakeCamp : get = get_MakeCamp
var TakeLeaves: PDTakeLeaves : get = get_TakeLeaves
var TakeRoots: PDTakeRoots : get = get_TakeRoots
var LegReveal: PDLegReveal : get = get_LegReveal
var FoodChoice: PDFoodChoice : get = get_FoodChoice
var EatAnyway: PDEatAnyway : get = get_EatAnyway
var LifeJacketBuild: PDLifeJacketBuild : get = get_LifeJacketBuild
var FogNavigation: PDFogNavigation : get = get_FogNavigation
var GetRoom: PDGetRoom : get = get_GetRoom
var GetBoat: PDGetBoat : get = get_GetBoat
var AirportEntry: PDAirportEntry : get = get_AirportEntry
var SuitcaseChoice: PDSuitcaseChoice : get = get_SuitcaseChoice
var KeepPartyTogether: PDKeepPartyTogether : get = get_KeepPartyTogether
var CrashPrep: PDCrashPrep : get = get_CrashPrep
# ---- nodes

# functions ----
func get_RoadMonstersApproach() -> PDRoadMonstersApproach: return get_instance("RoadMonstersApproach")
func get_TakeCones() -> PDTakeCones: return get_instance("TakeCones")
func get_TakeMapFlyer() -> PDTakeMapFlyer: return get_instance("TakeMapFlyer")
func get_FireSpiritChoice() -> PDFireSpiritChoice: return get_instance("FireSpiritChoice")
func get_AccidentChoice() -> PDAccidentChoice: return get_instance("AccidentChoice")
func get_SpaceDriftApproach() -> PDSpaceDriftApproach: return get_instance("SpaceDriftApproach")
func get_TakeDebris() -> PDTakeDebris: return get_instance("TakeDebris")
func get_GravityPuzzleIntro() -> PDGravityPuzzleIntro: return get_instance("GravityPuzzleIntro")
func get_MotorcycleApproach() -> PDMotorcycleApproach: return get_instance("MotorcycleApproach")
func get_TakeSignArrow() -> PDTakeSignArrow: return get_instance("TakeSignArrow")
func get_TakeDonutsReentry() -> PDTakeDonutsReentry: return get_instance("TakeDonutsReentry")
func get_PigRecruitment() -> PDPigRecruitment: return get_instance("PigRecruitment")
func get_FixStrap() -> PDFixStrap: return get_instance("FixStrap")
func get_CampSafety() -> PDCampSafety: return get_instance("CampSafety")
func get_PlanBoardIntro() -> PDPlanBoardIntro: return get_instance("PlanBoardIntro")
func get_SoldierEncounter() -> PDSoldierEncounter: return get_instance("SoldierEncounter")
func get_TakeBackpack() -> PDTakeBackpack: return get_instance("TakeBackpack")
func get_TakeVine() -> PDTakeVine: return get_instance("TakeVine")
func get_WerewolfChaseApproach() -> PDWerewolfChaseApproach: return get_instance("WerewolfChaseApproach")
func get_TakeThorn() -> PDTakeThorn: return get_instance("TakeThorn")
func get_MakeCamp() -> PDMakeCamp: return get_instance("MakeCamp")
func get_TakeLeaves() -> PDTakeLeaves: return get_instance("TakeLeaves")
func get_TakeRoots() -> PDTakeRoots: return get_instance("TakeRoots")
func get_LegReveal() -> PDLegReveal: return get_instance("LegReveal")
func get_FoodChoice() -> PDFoodChoice: return get_instance("FoodChoice")
func get_EatAnyway() -> PDEatAnyway: return get_instance("EatAnyway")
func get_LifeJacketBuild() -> PDLifeJacketBuild: return get_instance("LifeJacketBuild")
func get_FogNavigation() -> PDFogNavigation: return get_instance("FogNavigation")
func get_GetRoom() -> PDGetRoom: return get_instance("GetRoom")
func get_GetBoat() -> PDGetBoat: return get_instance("GetBoat")
func get_AirportEntry() -> PDAirportEntry: return get_instance("AirportEntry")
func get_SuitcaseChoice() -> PDSuitcaseChoice: return get_instance("SuitcaseChoice")
func get_KeepPartyTogether() -> PDKeepPartyTogether: return get_instance("KeepPartyTogether")
func get_CrashPrep() -> PDCrashPrep: return get_instance("CrashPrep")
# ---- functions

