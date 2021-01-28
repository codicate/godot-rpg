extends KinematicBody2D

onready var body = $Body
onready var hand = $Hand
onready var state = $State
onready var stat = $Stat
onready var HUD = $UI/HUD
onready var inventory = $UI/ItemMenu

onready var camera = get_node("/root/World/Camera2D")

var maxSpeed = 150
var acceleration = 600
var decceleration = 1200
var velocity = Vector2.ZERO

var maxDodgeSpeed = 400
var dodgeModifier = 8
var staminaCost = 50

var dodging = false


func _physics_process(delta):
	var mousePos = position.direction_to(get_global_mouse_position())

	body.flip_h = mousePos.x < 0
	hand.flip_h = mousePos.x < 0

	move(delta)

	if !state.interacting:
		if Input.is_action_just_pressed("inventory"):
			inventory.visible = !inventory.visible

	if Input.is_action_just_pressed("spacebar"):
		if dodging == false and stat.stamina - staminaCost >= 0:
			var previous_smoothing_speed = camera.smoothing_speed
			camera.smoothing_speed = 4.0
			HUD.update_stamina(staminaCost)
			dodging = true

			$DodgeTimer.start()
			if !$DodgeTimer.is_connected("timeout", self, "on_DodgeTimer_timeout"):
				var error = $DodgeTimer.connect("timeout", self, "on_DodgeTimer_timeout", [previous_smoothing_speed])
				if error != OK:
					print(error)


func move(delta):
	var inputVector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()

	if inputVector != Vector2.ZERO:
		body.play("run")
		hand.play("run")
		velocity = velocity.move_toward(maxSpeed * inputVector, acceleration * delta)

	else:
		body.play("idle")
		hand.play("idle")
		velocity = velocity.move_toward(Vector2.ZERO, decceleration * delta)

	if dodging:
		velocity = velocity.move_toward(maxDodgeSpeed * inputVector, acceleration * dodgeModifier * delta)

	velocity = move_and_slide(velocity)
#	print(velocity)


func on_DodgeTimer_timeout(previous_smoothing_speed):
	camera.smoothing_speed = previous_smoothing_speed
	dodging = false
