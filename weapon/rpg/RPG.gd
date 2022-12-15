extends Node2D


onready var Rocket = preload("res://weapon/rpg/Rocket.tscn")
onready var sprite = $Sprite
onready var muzzle = $Muzzle
onready var rockets = $Muzzle/Rockets
onready var muzzleFlash = $Muzzle/MuzzleFlash
onready var timer = $Timer

var equipped = false
var cooldown = false


func _physics_process(_delta):
	if equipped:
		if Input.is_action_pressed("clickl"):
			fire()


func fire():
	if !cooldown:
		if $Sprite.flip_v:
			$AnimationPlayer.play("recoilR")

		else:
			$AnimationPlayer.play("recoilL")

		$Sprite.play("empty")
		muzzleFlash.frame = 0
		muzzleFlash.visible = true
		muzzleFlash.playing = true

		var rocket = Rocket.instance()
		var rocketSpread = rand_range(-5, 5)

		rocket.rotation_degrees = muzzle.global_rotation_degrees + rocketSpread
		rocket.position = muzzle.global_position

		rockets.add_child(rocket)
		rocket.owner = self

		cooldown = true
		timer.start()


func _on_Cooldown_timeout():
	$Sprite.play("default")
	cooldown = false


func _on_MuzzleFlash_animation_finished():
	muzzleFlash.playing = false
	muzzleFlash.visible = false
