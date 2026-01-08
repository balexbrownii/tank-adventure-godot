@tool
extends "res://addons/popochiu/engine/interfaces/i_inventory.gd"

# classes ----
const PIHelmet := preload("res://game/inventory_items/helmet/inventory_item_helmet.gd")
const PIDonutBox := preload("res://game/inventory_items/donut_box/inventory_item_donut_box.gd")
const PIMapFlyer := preload("res://game/inventory_items/map_flyer/inventory_item_map_flyer.gd")
const PICone := preload("res://game/inventory_items/cone/inventory_item_cone.gd")
const PISpaceSoot := preload("res://game/inventory_items/space_soot/inventory_item_space_soot.gd")
const PIDebrisTrinket := preload("res://game/inventory_items/debris_trinket/inventory_item_debris_trinket.gd")
const PIMotorcycleKey := preload("res://game/inventory_items/motorcycle_key/inventory_item_motorcycle_key.gd")
const PIRoadSignArrow := preload("res://game/inventory_items/road_sign_arrow/inventory_item_road_sign_arrow.gd")
const PIPlushStuck := preload("res://game/inventory_items/plush_stuck/inventory_item_plush_stuck.gd")
const PICraftKit := preload("res://game/inventory_items/craft_kit/inventory_item_craft_kit.gd")
const PIMiniDonuts := preload("res://game/inventory_items/mini_donuts/inventory_item_mini_donuts.gd")
const PISpinachLeaves := preload("res://game/inventory_items/spinach_leaves/inventory_item_spinach_leaves.gd")
const PIRouteSketch := preload("res://game/inventory_items/route_sketch/inventory_item_route_sketch.gd")
const PIBackpack := preload("res://game/inventory_items/backpack/inventory_item_backpack.gd")
const PIBaconCrumbs := preload("res://game/inventory_items/bacon_crumbs/inventory_item_bacon_crumbs.gd")
const PIPosterScrap := preload("res://game/inventory_items/poster_scrap/inventory_item_poster_scrap.gd")
const PIRock := preload("res://game/inventory_items/rock/inventory_item_rock.gd")
const PIVine := preload("res://game/inventory_items/vine/inventory_item_vine.gd")
const PIThorn := preload("res://game/inventory_items/thorn/inventory_item_thorn.gd")
const PIStickyMud := preload("res://game/inventory_items/sticky_mud/inventory_item_sticky_mud.gd")
const PIHollowLogBark := preload("res://game/inventory_items/hollow_log_bark/inventory_item_hollow_log_bark.gd")
const PILeafBlanket := preload("res://game/inventory_items/leaf_blanket/inventory_item_leaf_blanket.gd")
const PILeafWrap := preload("res://game/inventory_items/leaf_wrap/inventory_item_leaf_wrap.gd")
const PIRootFiber := preload("res://game/inventory_items/root_fiber/inventory_item_root_fiber.gd")
const PICharcoalChunk := preload("res://game/inventory_items/charcoal_chunk/inventory_item_charcoal_chunk.gd")
const PIPoisonMushrooms := preload("res://game/inventory_items/poison_mushrooms/inventory_item_poison_mushrooms.gd")
const PISapBark := preload("res://game/inventory_items/sap_bark/inventory_item_sap_bark.gd")
const PIRockChalk := preload("res://game/inventory_items/rock_chalk/inventory_item_rock_chalk.gd")
const PILifeJacket := preload("res://game/inventory_items/life_jacket/inventory_item_life_jacket.gd")
const PILifeJacketBulky := preload("res://game/inventory_items/life_jacket_bulky/inventory_item_life_jacket_bulky.gd")
const PIOar := preload("res://game/inventory_items/oar/inventory_item_oar.gd")
const PIRaftPatch := preload("res://game/inventory_items/raft_patch/inventory_item_raft_patch.gd")
const PIRope := preload("res://game/inventory_items/rope/inventory_item_rope.gd")
const PIShellWhistle := preload("res://game/inventory_items/shell_whistle/inventory_item_shell_whistle.gd")
const PIMoistRope := preload("res://game/inventory_items/moist_rope/inventory_item_moist_rope.gd")
const PIDriftBottleNote := preload("res://game/inventory_items/drift_bottle_note/inventory_item_drift_bottle_note.gd")
const PIMotelKeycard := preload("res://game/inventory_items/motel_keycard/inventory_item_motel_keycard.gd")
const PIBoatToken := preload("res://game/inventory_items/boat_token/inventory_item_boat_token.gd")
const PITowel := preload("res://game/inventory_items/towel/inventory_item_towel.gd")
const PIReflectiveVest := preload("res://game/inventory_items/reflective_vest/inventory_item_reflective_vest.gd")
const PIClipboard := preload("res://game/inventory_items/clipboard/inventory_item_clipboard.gd")
const PIDestinationTag := preload("res://game/inventory_items/destination_tag/inventory_item_destination_tag.gd")
const PIZipperPull := preload("res://game/inventory_items/zipper_pull/inventory_item_zipper_pull.gd")
const PIStickerSheet := preload("res://game/inventory_items/sticker_sheet/inventory_item_sticker_sheet.gd")
const PISouvenirHat := preload("res://game/inventory_items/souvenir_hat/inventory_item_souvenir_hat.gd")
# ---- classes

# nodes ----
var Helmet: PIHelmet : get = get_Helmet
var DonutBox: PIDonutBox : get = get_DonutBox
var MapFlyer: PIMapFlyer : get = get_MapFlyer
var Cone: PICone : get = get_Cone
var SpaceSoot: PISpaceSoot : get = get_SpaceSoot
var DebrisTrinket: PIDebrisTrinket : get = get_DebrisTrinket
var MotorcycleKey: PIMotorcycleKey : get = get_MotorcycleKey
var RoadSignArrow: PIRoadSignArrow : get = get_RoadSignArrow
var PlushStuck: PIPlushStuck : get = get_PlushStuck
var CraftKit: PICraftKit : get = get_CraftKit
var MiniDonuts: PIMiniDonuts : get = get_MiniDonuts
var SpinachLeaves: PISpinachLeaves : get = get_SpinachLeaves
var RouteSketch: PIRouteSketch : get = get_RouteSketch
var Backpack: PIBackpack : get = get_Backpack
var BaconCrumbs: PIBaconCrumbs : get = get_BaconCrumbs
var PosterScrap: PIPosterScrap : get = get_PosterScrap
var Rock: PIRock : get = get_Rock
var Vine: PIVine : get = get_Vine
var Thorn: PIThorn : get = get_Thorn
var StickyMud: PIStickyMud : get = get_StickyMud
var HollowLogBark: PIHollowLogBark : get = get_HollowLogBark
var LeafBlanket: PILeafBlanket : get = get_LeafBlanket
var LeafWrap: PILeafWrap : get = get_LeafWrap
var RootFiber: PIRootFiber : get = get_RootFiber
var CharcoalChunk: PICharcoalChunk : get = get_CharcoalChunk
var PoisonMushrooms: PIPoisonMushrooms : get = get_PoisonMushrooms
var SapBark: PISapBark : get = get_SapBark
var RockChalk: PIRockChalk : get = get_RockChalk
var LifeJacket: PILifeJacket : get = get_LifeJacket
var LifeJacketBulky: PILifeJacketBulky : get = get_LifeJacketBulky
var Oar: PIOar : get = get_Oar
var RaftPatch: PIRaftPatch : get = get_RaftPatch
var Rope: PIRope : get = get_Rope
var ShellWhistle: PIShellWhistle : get = get_ShellWhistle
var MoistRope: PIMoistRope : get = get_MoistRope
var DriftBottleNote: PIDriftBottleNote : get = get_DriftBottleNote
var MotelKeycard: PIMotelKeycard : get = get_MotelKeycard
var BoatToken: PIBoatToken : get = get_BoatToken
var Towel: PITowel : get = get_Towel
var ReflectiveVest: PIReflectiveVest : get = get_ReflectiveVest
var Clipboard: PIClipboard : get = get_Clipboard
var DestinationTag: PIDestinationTag : get = get_DestinationTag
var ZipperPull: PIZipperPull : get = get_ZipperPull
var StickerSheet: PIStickerSheet : get = get_StickerSheet
var SouvenirHat: PISouvenirHat : get = get_SouvenirHat
# ---- nodes

# functions ----
func get_Helmet() -> PIHelmet: return get_item_instance("Helmet")
func get_DonutBox() -> PIDonutBox: return get_item_instance("DonutBox")
func get_MapFlyer() -> PIMapFlyer: return get_item_instance("MapFlyer")
func get_Cone() -> PICone: return get_item_instance("Cone")
func get_SpaceSoot() -> PISpaceSoot: return get_item_instance("SpaceSoot")
func get_DebrisTrinket() -> PIDebrisTrinket: return get_item_instance("DebrisTrinket")
func get_MotorcycleKey() -> PIMotorcycleKey: return get_item_instance("MotorcycleKey")
func get_RoadSignArrow() -> PIRoadSignArrow: return get_item_instance("RoadSignArrow")
func get_PlushStuck() -> PIPlushStuck: return get_item_instance("PlushStuck")
func get_CraftKit() -> PICraftKit: return get_item_instance("CraftKit")
func get_MiniDonuts() -> PIMiniDonuts: return get_item_instance("MiniDonuts")
func get_SpinachLeaves() -> PISpinachLeaves: return get_item_instance("SpinachLeaves")
func get_RouteSketch() -> PIRouteSketch: return get_item_instance("RouteSketch")
func get_Backpack() -> PIBackpack: return get_item_instance("Backpack")
func get_BaconCrumbs() -> PIBaconCrumbs: return get_item_instance("BaconCrumbs")
func get_PosterScrap() -> PIPosterScrap: return get_item_instance("PosterScrap")
func get_Rock() -> PIRock: return get_item_instance("Rock")
func get_Vine() -> PIVine: return get_item_instance("Vine")
func get_Thorn() -> PIThorn: return get_item_instance("Thorn")
func get_StickyMud() -> PIStickyMud: return get_item_instance("StickyMud")
func get_HollowLogBark() -> PIHollowLogBark: return get_item_instance("HollowLogBark")
func get_LeafBlanket() -> PILeafBlanket: return get_item_instance("LeafBlanket")
func get_LeafWrap() -> PILeafWrap: return get_item_instance("LeafWrap")
func get_RootFiber() -> PIRootFiber: return get_item_instance("RootFiber")
func get_CharcoalChunk() -> PICharcoalChunk: return get_item_instance("CharcoalChunk")
func get_PoisonMushrooms() -> PIPoisonMushrooms: return get_item_instance("PoisonMushrooms")
func get_SapBark() -> PISapBark: return get_item_instance("SapBark")
func get_RockChalk() -> PIRockChalk: return get_item_instance("RockChalk")
func get_LifeJacket() -> PILifeJacket: return get_item_instance("LifeJacket")
func get_LifeJacketBulky() -> PILifeJacketBulky: return get_item_instance("LifeJacketBulky")
func get_Oar() -> PIOar: return get_item_instance("Oar")
func get_RaftPatch() -> PIRaftPatch: return get_item_instance("RaftPatch")
func get_Rope() -> PIRope: return get_item_instance("Rope")
func get_ShellWhistle() -> PIShellWhistle: return get_item_instance("ShellWhistle")
func get_MoistRope() -> PIMoistRope: return get_item_instance("MoistRope")
func get_DriftBottleNote() -> PIDriftBottleNote: return get_item_instance("DriftBottleNote")
func get_MotelKeycard() -> PIMotelKeycard: return get_item_instance("MotelKeycard")
func get_BoatToken() -> PIBoatToken: return get_item_instance("BoatToken")
func get_Towel() -> PITowel: return get_item_instance("Towel")
func get_ReflectiveVest() -> PIReflectiveVest: return get_item_instance("ReflectiveVest")
func get_Clipboard() -> PIClipboard: return get_item_instance("Clipboard")
func get_DestinationTag() -> PIDestinationTag: return get_item_instance("DestinationTag")
func get_ZipperPull() -> PIZipperPull: return get_item_instance("ZipperPull")
func get_StickerSheet() -> PIStickerSheet: return get_item_instance("StickerSheet")
func get_SouvenirHat() -> PISouvenirHat: return get_item_instance("SouvenirHat")
# ---- functions

