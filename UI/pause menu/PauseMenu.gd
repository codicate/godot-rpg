extends CenterContainer


func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		visible = !visible
		get_tree().paused = !get_tree().paused


func _on_Button1_button_up():
	visible = !visible
	get_tree().paused = !get_tree().paused


func _on_Button2_button_up():
	pass # Replace with function body.


func _on_Button3_button_up():
	pass # Replace with function body.


func _on_Button4_button_up():
	get_tree().quit()
