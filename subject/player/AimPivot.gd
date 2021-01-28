extends Position2D

onready var hand = get_parent().get_node("Hand")

onready var weapons = $EquippedItem.get_children()
var currentWeapon = hand
var inv = 0


func _physics_process(_delta):
	look_at(get_global_mouse_position())
	var mousePos = global_position.direction_to(get_global_mouse_position())

	for weapon in weapons:
		weapon.get_node("Sprite").flip_v = mousePos.x < 0

	if Input.is_action_just_pressed("unequipped"):
		hand.visible = true
		currentWeapon = null
		switch_weapon()

	else:
		for i in weapons.size():
			if Input.is_action_just_pressed("inv" + str(i)):
				hand.visible = false
				currentWeapon = weapons[i]
				switch_weapon()


func switch_weapon():
	for weapon in weapons:
		if weapon == currentWeapon:
			weapon.visible = true
			weapon.equipped = true

		else:
			weapon.visible = false
			weapon.equipped = false


