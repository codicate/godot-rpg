extends Area2D

onready var muzzle = get_parent().get_parent()

var speed = 800

var explosionCounter = 0

var thing



func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta

	if position.distance_to(muzzle.global_position) > 800:
			queue_free()

	if thing != null:
		print("gfwge")
		print(thing.playing)


func explode():
	var currentExplosion = $Explosions.get_child(explosionCounter)
	currentExplosion.global_rotation = 0
	currentExplosion.show()
	currentExplosion.play("default")

	var currentExplosionSound = currentExplosion.get_node("AudioStreamPlayer2D")
	currentExplosionSound.play()

	if explosionCounter < $Explosions.get_child_count() - 1:
		explosionCounter += 1
		$ExplosionTimer.start()

	else:
		if !currentExplosion.is_connected("animation_finished", self, "_on_last_explosion_finished"):
			currentExplosion.connect("animation_finished", self, "_on_last_explosion_finished")

#		if !currentExplosionSound.is_connected("finished", self, "_on_last_explosion_finished"):
#			currentExplosionSound.connect("finished", self, "_on_last_explosion_finished")


func _on_Detector_area_entered(_area):
	$Sprite.hide()
	set_physics_process(false)
	$CollisionShape2D.set_deferred("disabled", false)
	explode()


func _on_ExplosionTimer_timeout():
	explode()


func _on_last_explosion_finished():
	print("gegee")
	queue_free()
