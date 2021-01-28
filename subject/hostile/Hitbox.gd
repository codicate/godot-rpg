extends Area2D

onready var collShape = $CollisionShape2D
onready var timer = $Timer


func _on_Hitbox_area_entered(_area):
	collShape.set_deferred("disabled", true)
	timer.start()


func _on_Cooldown_timeout():
	collShape.disabled = false
