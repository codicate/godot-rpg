extends Area2D

onready var HUD = get_owner().get_node("UI/HUD")


func _on_Hurtbox_area_entered(area):
	var dmg = area.get_owner().get_node("Stat").dmg
	var HP = HUD.update_health(dmg)

	var screenshake = get_node("/root/World/Camera2D/Screenshake")
	screenshake.start(dmg * 4, 15, 0.3)

	if HP <= 0:
		get_node("/root/World/UI/DeathScreen").show()
		get_parent().queue_free()
