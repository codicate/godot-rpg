extends Panel

onready var Chunk = preload("res://UI/healthbar/Chunk.tscn")

onready var stat = get_owner().get_node("Stat")
onready var chunks = $Chunks
onready var timer = $Timer

var currentHP = null


func _ready():
	var maxHP = stat.maxHP
	var width = maxHP * 2 + 1

	rect_size.x = width
	rect_size.y = 3

	rect_position.x = -width / 2
	rect_position.y = 2

	for i in maxHP:
		var chunk = Chunk.instance()
		chunks.add_child(chunk)


func update_health(HP):
	currentHP = chunks.get_child_count()

	if HP >= 0:
		for i in range(currentHP - HP):
			chunks.get_children()[i].queue_free()

	show()
	timer.start()


func _on_Timer_timeout():
	hide()
