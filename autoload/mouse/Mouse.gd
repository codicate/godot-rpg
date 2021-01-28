extends Node2D

onready var ani = $AnimatedSprite


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(_delta):
	global_position = get_global_mouse_position()

	if Input.is_action_just_pressed("clickl"):
		ani.play("click")

	elif Input.is_action_just_released("clickl"):
		ani.play("click", true)
