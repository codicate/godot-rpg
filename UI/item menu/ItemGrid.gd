extends GridContainer

onready var itemMenu = get_parent()

var itemList


func ready():
	itemList = itemMenu.itemList
	itemMenu.connect("item_changed", self, "_on_item_changed")

	for index in itemList.size():
		get_child(index).ready()
		update_items_slot(index)


func update_items_slot(index):
	var itemsSlot = get_child(index)
	var item = itemList[index]
	itemsSlot.display_item(item)


func _on_item_changed(indexes):
	for index in indexes:
		update_items_slot(index)


func transferItem(index,item):
	itemMenu.place(index, item)
