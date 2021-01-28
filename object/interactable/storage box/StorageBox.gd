extends StaticBody2D

onready var itemMenu = $UI/ItemMenu
onready var interactionZone = $InteractionZone
onready var ani = $AnimatedSprite
onready var mainUI = get_node("/root/World/UI")

var interactor = null

var opened = false

func _ready():
	itemMenu.get_node("ItemGrid").columns = 2
	itemMenu.get_node("ItemGrid").anchor_left = 0.2

func _process(_delta):


	if interactionZone.interactor != null:
		interactor = interactionZone.interactor

		if Input.is_action_just_pressed("interact"):
			opened = !opened

			if opened:
				open()
			else:
				close()

	else:
		if opened:
			opened = false
			close()


func open():
	ani.play("open")
	if !ani.is_connected("animation_finished", self, "_on_AnimatedSprite_animation_finished"):
		ani.connect("animation_finished", self, "_on_AnimatedSprite_animation_finished")


func _on_AnimatedSprite_animation_finished():
	ani.disconnect("animation_finished", self, "_on_AnimatedSprite_animation_finished")

	if opened:
		itemMenu.visible = true

		var inventoryGrid = interactor.get_node("UI/ItemMenu/ItemGrid")
		interactor.get_node("UI/ItemMenu").remove_child(inventoryGrid)
		itemMenu.add_child(inventoryGrid)
		inventoryGrid.name = "InventoryGrid"


func close():
	ani.play("close")

	if itemMenu.visible == true:
		itemMenu.visible = false
		interactor.get_node("UI/ItemMenu").visible = false

		var inventoryGrid = get_node("UI/ItemMenu/InventoryGrid")
		itemMenu.remove_child(inventoryGrid)
		interactor.get_node("UI/ItemMenu").add_child(inventoryGrid)
		inventoryGrid.name = "ItemGrid"
