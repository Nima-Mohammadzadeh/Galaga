#Bullet
extends CharacterBody2D

const speed = 800
var direction = Vector2.UP

func _ready():
	add_to_group("bullet")

func _process(delta):
	var collisionResult = move_and_collide(direction * speed * delta)
	if collisionResult != null:
		print("works!")
		queue_free()
	

