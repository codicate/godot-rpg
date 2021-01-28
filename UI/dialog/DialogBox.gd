extends Control

onready var label = $Label
onready var paragraph = $Paragraph
onready var tween = $Tween
onready var nextIndicator = $NextIndicator

var state

var textSpeed : float = 40
var textIndex = 0
var finished = false

var characterName = "NAME"

var text = [
	"# # # PLACEHOLDER # # #"
]


func _ready():
	get_tree().paused = true
	label.text = characterName
	loadDialog()


func _process(_delta):
	nextIndicator.visible = finished

	if Input.is_action_just_pressed("spacebar"):
		if !finished:
			paragraph.percent_visible = 1
			tween.remove(paragraph, "percent_visible")
			finished = true

		else:
			loadDialog()


func loadDialog():
	if textIndex < text.size():
		state.interacting = true
		finished = false

		paragraph.percent_visible = 0
		paragraph.bbcode_text = text[textIndex]

		tween.interpolate_property(
			paragraph, "percent_visible", 0, 1,
			text[textIndex].length() / textSpeed,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		tween.start()

		textIndex += 1

	else:
		get_tree().paused = false
		state.interacting = false
		queue_free()


func _on_Tween_tween_completed(_object, _key):
	finished = true
