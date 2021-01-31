extends Control



func _on_Button1_button_up():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://World.tscn")


func _on_Button2_button_up():
	pass # Replace with function body.


func _on_Button3_button_up():
	pass # Replace with function body.


func _on_Button4_button_up():
	get_tree().quit()
