extends Node

onready var droppedItem = preload("res://UI/item menu/DroppedItem.tscn")

export (Array, Resource) var items


func randomDrop():
	if items.size() != 0:
		var item = items[rand_range(0, items.size())]
		if item != null:
			var drop = droppedItem.instance()
			drop.position = get_owner().position
			drop.item = item
			get_node("/root/World/YSort/Items").add_child(drop)
