extends Area2D

onready var stat = get_owner().get_node("Stat")
onready var lootTable = get_owner().get_node("LootTable")
onready var healthBar = get_owner().get_node("Healthbar")
onready var ani = get_owner().get_node("AnimatedSprite")
onready var collShape = $CollisionShape2D

onready var HP = stat.HP


func _on_Hurtbox_area_entered(area):
	var dmg = area.get_owner().get_node("Stat").dmg
	HP -= dmg
	healthBar.update_health(HP)

	var screenshake = get_node("/root/World/Camera2D/Screenshake")
	screenshake.start(dmg, 20, 0.1)

	if HP <= 0:
		collShape.set_deferred("disabled", true)
		get_parent().set_physics_process(false)

		ani.play("Death")
		ani.connect("animation_finished", self, "on_death_animation_finished")


func on_death_animation_finished():
	lootTable.randomDrop()
	get_parent().queue_free()
