extends CenterContainer

onready var textureRect = $TextureRect
onready var label = $TextureRect/Label

onready var itemMenu = get_parent().get_parent()
var itemList

var mouseEntered = false


func ready():
	itemList = itemMenu.itemList


func display_item(item):
	if item is Item:
		textureRect.texture = item.texture

		if item.stackable:
			label.text = str(item.amount)

	else:
		textureRect.texture = null
		label.text = ""


func get_drag_data(_position):
	var index = get_index()
	var item = itemMenu.remove(index)

	if item is Item:
		var data = {
			item = item,
			index = index,
			belong2 = get_parent()
		}

		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		set_drag_preview(dragPreview)

		itemMenu.drag_data = data

		return data


func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")


func drop_data(_position, data):
	var index = get_index()
	var item = itemList[index]

	if item is Item and item.name == data.item.name and item.stackable:
		item.amount += data.item.amount
		itemMenu.emit_signal("item_changed", [index])

	elif get_parent() != data.belong2:
		var previousItem = itemMenu.place(index, data.item)
		data.belong2.transferItem(data.index, previousItem)

	else:
		itemMenu.swap(index, data.index)
		itemMenu.place(index, data.item)

	itemMenu.drag_data = null


func _process(_delta):
	if mouseEntered and Input.is_action_just_pressed("clickr"):
		var index = get_index()
		if itemList[index] != null:
			use(itemList[index].name)

			if itemList[index].stackable and itemList[index].amount > 1:
				itemList[index].amount -= 1
			else:
				itemList[index] = null

			display_item(itemList[index])


func use(item):
	var HUD = itemMenu.get_parent().get_node("HUD")
	match item:
		"Medkit":
			HUD.regenerateHP()
		"22mm Ammo":
			pass
		"Pill":
			HUD.freezeStamina()


func _on_TextureRect_mouse_entered():
	mouseEntered = true


func _on_TextureRect_mouse_exited():
	mouseEntered = false
