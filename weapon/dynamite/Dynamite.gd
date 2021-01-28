extends Node2D

onready var Projectile = preload("res://weapon/dynamite/DynamiteProjectile.tscn")

onready var timer = $CooldownTimer
onready var projectiles = $Projectiles
onready var ani = $Sprite

var equipped = false
var cooldown = false
var ignited = false


func _physics_process(_delta):
	if equipped and !cooldown:
		if Input.is_action_just_pressed("clickl"):
			ignite()
		elif Input.is_action_just_released("clickl"):
			throw()

	else:
		ani.play("unignited")


func ignite():
	ani.play("igniting")
	if !ani.is_connected("animation_finished", self, "on_igniting_animation_finished"):
		ani.connect("animation_finished", self, "on_igniting_animation_finished")


func on_igniting_animation_finished():
	ani.play("ignited")
	ignited = true


func throw():
	if ani.is_connected("animation_finished", self, "on_igniting_animation_finished"):
		ani.disconnect("animation_finished", self, "on_igniting_animation_finished")
	ani.play("unignited")

	if ignited:
		var projectile = Projectile.instance()
		projectile.position = global_position

		projectiles.add_child(projectile)
		projectile.owner = self

		ignited = false
		cooldown = true
		timer.start()


func _on_Timer_timeout():
	cooldown = false
