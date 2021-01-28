extends Control
signal item_changed(indexes)

onready var ItemSlot = preload("res://UI/item menu/ItemSlot.tscn")
onready var DroppedItem = preload("res://UI/item menu/DroppedItem.tscn")
onready var itemList = get_parent().get_parent().get_node("ItemList").itemList

var drag_data = null


func _ready():
	visible = false

	var uniqueItemList = []
	for item in itemList:
		var itemslot = ItemSlot.instance()
		$ItemGrid.add_child(itemslot)

		if item is Item:
			uniqueItemList.append(item.duplicate())
		else:
			uniqueItemList.append(null)

	itemList = uniqueItemList
	$ItemGrid.ready()


func place(index, item):
	var previousItem = itemList[index]
	itemList[index] = item
	emit_signal("item_changed", [index])
	print("place", item, index)
	return previousItem


func swap(index, targetIndex):
	var item = itemList[index]

	if item is Item:
		var targetItem = itemList[targetIndex]
		itemList[index] = targetItem
		itemList[targetIndex] = item

		emit_signal("item_changed", [index, targetIndex])
		print("swap", item, targetItem)


func remove(index):
	var previousItem = itemList[index]
	itemList[index] = null
	emit_signal("item_changed", [index])
	print("remove", previousItem)
	return previousItem


func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")


func drop_data(_position, data):
	var drop = DroppedItem.instance()
	var mousePos = get_node("/root/World").get_global_mouse_position()
	drop.position = mousePos
	drop.item = data.item
	get_node("/root/World/YSort/Items").add_child(drop)
