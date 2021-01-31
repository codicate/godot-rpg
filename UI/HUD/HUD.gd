extends TextureRect

onready var Chunk = preload("res://UI/HUD/Chunk.tscn")

onready var tween = $Tween
onready var chunks = $Chunks
onready var progressBar = $ProgressBar

onready var stat = get_owner().get_node("Stat")

onready var maxHP = stat.maxHP
onready var maxStamina = stat.maxStamina

var isStaminaFrozen = false


func _ready():
	progressBar.max_value = maxStamina
	progressBar.value = maxStamina

	regenerateHP()


func regenerateHP():
	var currentHP = chunks.get_child_count()
	for i in maxHP - currentHP:
		var chunk = Chunk.instance()
		chunks.add_child(chunk)

	stat.HP = maxHP


func freezeStamina():
	isStaminaFrozen = true
	$FreezeStamina.start()


func update_health(dmg):
	var currentHP = stat.HP
	var HP = max(0, currentHP - dmg)

	if dmg >= 0:
		for i in range(currentHP - HP):
			chunks.get_children()[i].queue_free()

	stat.HP = HP
	return HP


func update_stamina(staminaCost):
	if !isStaminaFrozen:
		stat.stamina -= staminaCost
		progressBar.value -= staminaCost

		tween.interpolate_property(
			stat, "stamina", stat.stamina, maxStamina, 3,
			Tween.TRANS_SINE, Tween.EASE_OUT
		)

		tween.interpolate_property(
			progressBar, "value", progressBar.value, maxStamina, 3,
			Tween.TRANS_SINE, Tween.EASE_OUT
		)
		tween.start()


func _on_FreezeStamina_timeout():
	isStaminaFrozen = false
