extends Area2D

onready var stat = get_parent().get_node("Stat")
onready var lootTable = get_parent().get_node("LootTable")
onready var healthBar = get_parent().get_node("Healthbar")
onready var ani = get_parent().get_node("AnimatedSprite")

onready var HP = stat.HP


func _on_Hurtbox_area_entered(area):
	if area.name != "Detector":
		$AudioStreamPlayer2D.play()

		var dmg = area.get_owner().get_node("Stat").dmg
		var playerStat = area.get_owner().get_owner().get_node("Stat")
		var dmgModifier = playerStat.dmgModifier
		HP = max(0, HP - dmg * dmgModifier)
		healthBar.update_health(HP)

		var screenshake = get_node("/root/World/Camera2D/Screenshake")
		screenshake.start(dmg, 20, 0.1)

		if HP <= 0:
			playerStat.XP += 20
			playerStat.canILevelUp()

			$CollisionShape2D.set_deferred("disabled", true)
			get_parent().get_node("Hitbox/CollisionShape2D").set_deferred("disabled", true)
			get_parent().set_physics_process(false)

			ani.play("Death")
			if !ani.is_connected("animation_finished", self, "on_death_animation_finished"):
				ani.connect("animation_finished", self, "on_death_animation_finished")


func on_death_animation_finished():
	lootTable.randomDrop()
	get_parent().queue_free()
