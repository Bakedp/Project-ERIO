extends Area2D

#cercare interazione con area2d per cambiare scena
func _ready():
	_on_porta_body_entered("body")

func _on_porta_body_entered(body):
	if (body.get_name() == "Erio"):
		print("a")
