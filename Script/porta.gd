extends Area2D

func _on_porta_body_entered(body):
	queue_free()
#cercare interazione con area2d per cambiare scena
func _ready():
	_on_porta_body_entered("body")

