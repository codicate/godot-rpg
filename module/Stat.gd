extends Node


export var maxHP = 10
onready var HP = maxHP

export var maxStamina = 100
onready var stamina = maxStamina

export (float) var dmgModifier = 1

var level = 1
var XP = 0


func _process(_delta):
	if Input.is_action_just_pressed("clickm"):
		XP += 20
		print(XP)
		canILevelUp()


func canILevelUp():
	var levelUPXP = [100, 200, 300, 500, 1000]
	if XP >= levelUPXP[level - 1]:
		if level < 5:
			level += 1
			dmgModifier = dmgModifier * (level * 1.0/10.0 + 1)
			var levelUPMessage = get_node("/root/World/UI/LevelledUP")
			levelUPMessage.visible = true
			levelUPMessage.get_node("MessageTimer").start()

		else:
			print("Impressive")

