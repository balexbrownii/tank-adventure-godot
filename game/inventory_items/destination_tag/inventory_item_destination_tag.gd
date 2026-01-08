@tool
extends PopochiuInventoryItem

## Destination Tag: Texas
## Key routing item from the tag text puzzle


func _on_click() -> void:
	await C.Tank.say("TEXAS! Our destination!")


func _on_right_click() -> void:
	await C.Tank.say("A tag with 'TEXAS' written on it. Our ticket to the right plane.")


func _on_look() -> void:
	await C.Tank.say("The scrambled letters now clearly spell TEXAS.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	pass
