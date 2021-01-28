extends StaticBody2D

onready var UI = $UI
onready var interactionZone = $InteractionZone

onready var Dialog = preload("res://UI/dialog/DialogBox.tscn")


func _process(_delta):
	var interactor = interactionZone.interactor

	if interactor != null:
		if Input.is_action_just_pressed("interact"):
			var dialog = Dialog.instance()

			dialog.state = interactor.get_node("State")
			dialog.characterName = "The King"
			dialog.text = [
				"Brave soldier, please stop by",
				"These zombies ahead are unsually harmless. They had been idling all day, while other zombies are rampaging my village.",
				"They must be diseased. You must kill them."
			]

			UI.add_child(dialog)
