extends PopochiuRoomData
## Room state for Space Drift - tracks puzzle progress and approach used

## Which solution was used to return to Earth
var solution_used: String = ""

## Whether Tank has examined Earth in Reality Vision
var earth_examined_reality: bool = false

## Whether Tank has examined the Case File overlay
var case_file_examined: bool = false

## Whether Tank has found the donut scent trail
var donut_trail_found: bool = false

## Whether Tank has collected debris
var debris_collected: bool = false

## Swim rhythm puzzle progress (for Brawn approach)
var swim_strokes_correct: int = 0
var swim_strokes_needed: int = 4

## Panel puzzle progress (for Brains approach)
var gravity_arrows_aligned: bool = false

## Whether Tank is currently spinning (fail-forward state)
var is_spinning: bool = false
