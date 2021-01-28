extends Area2D


var target = null


func _on_Detector_body_entered(body):
	target = body


func _on_Detector_body_exited(_body):
	target = null
