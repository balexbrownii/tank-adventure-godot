extends PopochiuRoomData
## Room state for Oak Tree Camp - Plan Board and first night camp

## Which solution was used to secure camp
var solution_used: String = ""

## Whether the camp was secured
var camp_secured: bool = false

## Whether the intro sequence has played
var intro_complete: bool = false

## Whether the plan board has been viewed
var plan_viewed: bool = false

## Whether the route sketch was received
var route_sketch_received: bool = false

## Whether the raccoon stole the donuts (fail-forward)
var raccoon_stole_donuts: bool = false

## Whether Tank examined the plan in Reality Vision
var plan_examined_reality: bool = false

## Whether breakfast scene played
var breakfast_done: bool = false
