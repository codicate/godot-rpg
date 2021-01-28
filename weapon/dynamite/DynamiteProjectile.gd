extends Area2D

onready var sprite = $DynamiteSprite
onready var ani = $ExplosionAnimation
onready var tween = $Tween
onready var coll = $CollisionShape2D

var speed = 150

onready var mousePos = get_global_mouse_position()
onready var airTime = global_position.distance_to(mousePos) / speed
onready var vertex = -60 * airTime


func _ready():
	sprite.flip_h = mousePos.x < 0

	tween.interpolate_property(
		sprite, "position",
		Vector2.ZERO, Vector2(0, vertex), airTime / 2,
		Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	tween.start()


func _on_Tween_tween_completed(_object, _key):
	tween.interpolate_property(
		sprite, "position",
		Vector2(0, vertex), Vector2.ZERO, airTime / 2,
		Tween.TRANS_QUAD, Tween.EASE_IN
	)
	tween.start()


func _physics_process(delta):
	global_position = global_position.move_toward(mousePos, speed * delta)
	var distance = global_position.distance_to(mousePos)

	if distance == 0:
		explode()


func explode():
	set_physics_process(false)
	coll.disabled = false

	sprite.hide()
	ani.show()
	ani.play("explode")


func _on_ExplosionAnimation_animation_finished():
	queue_free()
