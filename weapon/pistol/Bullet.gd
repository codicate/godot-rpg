extends Area2D

onready var muzzle = get_parent().get_parent()

var speed = 800


func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta

	if position.distance_to(muzzle.global_position) > 800:
			queue_free()


func _on_Bullet_area_entered(_area):
	queue_free()
