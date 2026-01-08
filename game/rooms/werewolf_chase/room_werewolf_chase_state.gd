extends PopochiuRoomData
## Room state for Werewolf Chase Path

## Which solution was used to escape
var solution_used: String = ""

## Whether the chase sequence has started
var chase_started: bool = false

## Whether Tank escaped the werewolf
var escaped: bool = false

## Whether Tank faceplanted in mud (fail-forward)
var mud_faceplant: bool = false

## Whether Tank collected the thorn
var thorn_taken: bool = false

## Whether Tank collected sticky mud
var sticky_mud_taken: bool = false

## Whether Tank collected hollow log bark
var hollow_log_bark_taken: bool = false

## Whether Tank triggered the tripline
var triggered_tripline: bool = false

## Whether Tank attempted the "honorable duel"
var attempted_duel: bool = false
