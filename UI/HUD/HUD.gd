extends TextureRect

onready var Chunk = preload("res://UI/HUD/Chunk.tscn")

onready var tween = $Tween
onready var chunks = $Chunks
onready var progressBar = $ProgressBar

onready var stat = get_owner().get_node("Stat")

onready var maxHP = stat.maxHP
onready var maxStamina = stat.maxStamina


func _ready():
	progressBar.max_value = maxStamina
	progressBar.value = maxStamina

	for i in maxHP:
		var chunk = Chunk.instance()
		chunks.add_child(chunk)


func update_health(dmg):
	var currentHP = chunks.get_child_count()
	var HP = max(0, currentHP - dmg)

	if dmg >= 0:
		for i in range(currentHP - HP):
			chunks.get_children()[i].queue_free()

	return HP


func update_stamina(staminaCost):
	stat.stamina -= staminaCost
	progressBar.value -= staminaCost

	tween.interpolate_property(
		stat, "stamina", stat.stamina, maxStamina, 2,
		Tween.TRANS_SINE, Tween.EASE_OUT
	)

	tween.interpolate_property(
		progressBar, "value", progressBar.value, maxStamina, 2,
		Tween.TRANS_SINE, Tween.EASE_OUT
	)
	tween.start()
