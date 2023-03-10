extends Node2D


onready var Bullet = preload("res://weapon/pistol/Bullet.tscn")
onready var sprite = $Sprite
onready var muzzle = $Muzzle
onready var bullets = $Muzzle/Bullets
onready var timer = $Timer

var equipped = false
var cooldown = false


func _physics_process(_delta):
	$Muzzle/MuzzleFlash.visible = false

	if equipped:
		if Input.is_action_pressed("clickl"):
			fire()
		else:
			$AnimationPlayer.play("default")


func fire():
	if $Sprite.flip_v:
		$AnimationPlayer.play("recoilL")

	else:
		$AnimationPlayer.play("recoilR")

	if !cooldown:
		$AudioStreamPlayer.play()
		$Muzzle/MuzzleFlash.visible = true

		var bullet = Bullet.instance()
		var bulletSpread = rand_range(-5, 5)

		bullet.rotation_degrees = muzzle.global_rotation_degrees + bulletSpread
		bullet.position = muzzle.global_position

		bullets.add_child(bullet)
		bullet.owner = self

		cooldown = true
		timer.start()


func _on_Cooldown_timeout():
	cooldown = false
