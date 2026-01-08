@tool
extends PopochiuInventoryItem

## Souvenir Hat - fail-forward consolation prize from wrong suitcase
## Comedy item, may have minor uses later


func _on_click() -> void:
	await C.Tank.say("A hat! From... Alaska?")


func _on_right_click() -> void:
	await C.Tank.say("A souvenir hat from my accidental trip to the wrong baggage claim.")


func _on_look() -> void:
	await C.Tank.say("It says 'I WENT TO ALASKA AND ALL I GOT WAS THIS HAT'")
	await C.Tank.say("But I didn't even get there!")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	pass
