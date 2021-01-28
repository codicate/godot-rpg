extends KinematicBody2D

onready var droppedItem = preload("res://UI/item menu/DroppedItem.tscn")

onready var ani = $AnimatedSprite
onready var detector = $Detector

var maxSpeed = 100
var acceleration = 400
var decceleration = 800
var velocity = Vector2.ZERO

var target = null


func _physics_process(delta):
	move(delta)


func move(delta):
	target = detector.target

	if target != null:
		var direction = position.direction_to(target.position)
		ani.flip_h = direction.x > 0
		velocity = velocity.move_toward(maxSpeed * direction, acceleration * delta)

	else:
		velocity = velocity.move_toward(Vector2.ZERO, decceleration * delta)

	velocity = move_and_slide(velocity)
