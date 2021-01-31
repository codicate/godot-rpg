extends KinematicBody2D

onready var droppedItem = preload("res://UI/item menu/DroppedItem.tscn")

onready var ani = $AnimatedSprite
onready var detector = $Detector

var maxSpeed = 100
var acceleration = 400
var decceleration = 800
var velocity = Vector2.ZERO

var hardColliding = false
var knockback = Vector2.ZERO

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

	velocity += knockback * 3


	velocity = move_and_slide(velocity)


func _on_HardCollision_body_entered(body):
	if (body.name == "Player" and body.dodging or
		body.name == "Enemy" and body.hardColliding):
		hardColliding = true
		knockback = body.velocity


func _on_HardCollision_body_exited(body):
	if (body.name == "Player" and body.dodging or
		body.name == "Enemy" and body.hardColliding):
		hardColliding = false
		knockback = Vector2.ZERO
