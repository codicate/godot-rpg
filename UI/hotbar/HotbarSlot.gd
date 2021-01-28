extends CenterContainer

onready var textureRect = $TextureRect
onready var label = $TextureRect/Label

var inventory = preload("res://UI/inventory/Inventory.tres")


func display_item(item):
	if item is Item:
		textureRect.texture = item.texture

		if item.stackable:
			label.text = str(item.amount)

	else:
		textureRect.texture = null
		label.text = ""
