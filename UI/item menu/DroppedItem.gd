extends Area2D

var inventory

var item : Item = null


func _ready():
	$Item.texture = item.texture


func find_slot():
	for index in inventory.itemList.size():
		var previousItem = inventory.itemList[index]

		if previousItem is Item and item.name == previousItem.name:
			item.amount += previousItem.amount
			return index


func find_empty_slot():
	for index in inventory.itemList.size():
		var previousItem = inventory.itemList[index]

		if not previousItem is Item:
			return index


func _on_DroppedItem_body_entered(body):
	inventory = body.get_node("UI/ItemMenu")
	var index = null

	if item.stackable:
		index = find_slot()

		if index == null:
			index = find_empty_slot()

	else:
		index = find_empty_slot()

	if index != null:
		inventory.place(index, item)

	queue_free()
