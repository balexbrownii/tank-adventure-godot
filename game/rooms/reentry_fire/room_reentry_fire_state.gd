extends PopochiuRoomData
## Room state for Re-entry Fire + Motorcycle Escape

## Which solution was used to start the motorcycle
var solution_used: String = ""

## Whether Tank has examined the motorcycle in Reality Vision
var motorcycle_examined_reality: bool = false

## Whether Tank has found the motorcycle key
var key_found: bool = false

## Whether Tank took the road sign arrow
var sign_arrow_taken: bool = false

## Whether Tank grabbed the donut box (temptation item)
var donut_box_taken: bool = false

## Whether the landing sequence has played
var landing_complete: bool = false

## Fail-forward: crashed into plushie pile
var crashed_into_plushies: bool = false
