@tool
extends PopochiuInventoryItem

## Sticker Sheet - leftover letter stickers from Pig's craft solution
## Can be used to relabel things or create fake documents


func _on_click() -> void:
	await C.Tank.say("Stickers! I love stickers!")


func _on_right_click() -> void:
	await C.Tank.say("A sheet of alphabet stickers. Leftovers from making the Texas tag.")


func _on_look() -> void:
	await C.Tank.say("Letters A through Z. Could spell anything!")

	if GameState.has_party_member("Pig"):
		await C.player.say("For official-looking paperwork. Or pranks.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	pass
