extends PopochiuRoomData
## Room state for Wanted Camp - Tutorial/Opening room

## Which solution was used to escape soldiers
var solution_used: String = ""

## Whether the intro sequence has played
var intro_complete: bool = false

## Whether soldiers have arrived
var soldiers_arrived: bool = false

## Whether Tank escaped the soldiers
var escaped: bool = false

## Whether Tank was caught (fail-forward)
var was_caught: bool = false

## Whether Tank picked up the backpack
var backpack_taken: bool = false

## Whether Tank picked up the vine
var vine_taken: bool = false

## Whether Tank picked up a rock
var rock_taken: bool = false

## Whether Tank has the bacon crumbs
var bacon_crumbs_taken: bool = false

## Whether Tank took the poster scrap (optional)
var poster_scrap_taken: bool = false

## Whether Tank examined the poster in Reality Vision
var poster_examined_reality: bool = false

## Whether Tank used bacon crumbs as lure
var used_bacon_lure: bool = false
