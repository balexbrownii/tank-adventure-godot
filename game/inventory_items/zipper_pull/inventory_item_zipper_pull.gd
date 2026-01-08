@tool
extends PopochiuInventoryItem

## Zipper Pull - small tool for prying/picking
## Can be used on locks, latches, or tight spaces


func _on_click() -> void:
	await C.Tank.say("A little metal tooth. Could be useful!")


func _on_right_click() -> void:
	await C.Tank.say("A zipper pull. Small but might work as a picking tool.")


func _on_look() -> void:
	await C.Tank.say("Metal and small. Good for prying or picking.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	pass
