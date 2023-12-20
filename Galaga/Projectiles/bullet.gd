extends Area2D

var speed = 800

func _process(delta):
	position.y -= speed * delta

