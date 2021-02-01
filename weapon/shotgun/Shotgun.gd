extends Node2D


onready var Bullet = preload("res://Weapon/pistol/Bullet.tscn")
onready var sprite = $Sprite
onready var muzzle = $Muzzle
onready var bullets = $Muzzle/Bullets
onready var timer = $Timer

var equipped = false
var cooldown = false


func _physics_process(_delta):
	$Muzzle/MuzzleFlash.visible = false

	if equipped:
		if Input.is_action_just_pressed("clickl"):
			fire()


func fire():
	if !cooldown:
		if $Sprite.flip_v:
			$AnimationPlayer.play("recoilR")

		else:
			$AnimationPlayer.play("recoilL")

		$Muzzle/MuzzleFlash.visible = true
		$AudioStreamPlayer.play()

		for i in 10:
			var bullet = Bullet.instance()
			var bulletSpread = rand_range(-10, 10)

			bullet.rotation_degrees = muzzle.global_rotation_degrees + bulletSpread
			bullet.position = muzzle.global_position

			bullets.add_child(bullet)
			bullet.owner = self

		cooldown = true
		timer.start()


func _on_Cooldown_timeout():
	cooldown = false
