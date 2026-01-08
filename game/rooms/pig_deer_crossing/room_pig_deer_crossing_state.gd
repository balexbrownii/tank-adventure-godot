extends PopochiuRoomData
## Room state for Pig + Deer Crossing - Party recruitment room

## Which solution was used to recruit Pig
var solution_used: String = ""

## Whether Tank has apologized to Pig
var apologized: bool = false

## Whether Tank has examined Pig in Reality Vision
var pig_examined_reality: bool = false

## Whether Tank has examined the deer
var deer_examined: bool = false

## Whether the intro sequence has played
var intro_complete: bool = false

## Whether Pig has joined the party
var pig_joined: bool = false

## Whether the fail-forward strap fix task was given
var strap_task_given: bool = false

## Whether the strap was fixed (fail-forward path)
var strap_fixed: bool = false

## Pig's current mood (affects dialogue options)
## Values: "angry", "annoyed", "neutral", "friendly"
var pig_mood: String = "angry"
