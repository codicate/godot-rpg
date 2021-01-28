extends Area2D


var interactor = null


func _on_InteractionZone_body_entered(body):
	interactor = body


func _on_InteractionZone_body_exited(_body):
	interactor = null
