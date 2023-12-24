#Player
extends CharacterBody2D
class_name Player
# speed, life and screen constraints
@export var life = 10
@export var SPEED = 400
const LEFT_BOUNDARY = 45
const RIGHT_BOUNDARY = 1240
const TOP_BOUNDARY = 50
const BOTTOM_BOUNDARY = 670

var BULLET: PackedScene = preload("res://Projectiles/bullet.tscn")
@onready var bullet_marker = $Marker2D
@onready var shoot_timer = $ShotTimer

func get_input():
	var input_direction = Input.get_vector("left","right","up","down")
	velocity = input_direction * SPEED

func shoot():
	var b = BULLET.instantiate()
	b.position = bullet_marker.global_position
	get_tree().current_scene.add_child(b)
	shoot_timer.start()

#shooting of ship
func _input(_event):
	if Input.is_action_pressed("shoot") and shoot_timer.is_stopped():
		shoot()

#check user for input of ship
func _physics_process(delta):
	get_input()
	move_and_slide()
	# Constrain the spaceship within the boundaries
	position.x = clamp(position.x, LEFT_BOUNDARY, RIGHT_BOUNDARY)
	position.y = clamp(position.y, TOP_BOUNDARY, BOTTOM_BOUNDARY)

func damage(amount: int):
	life -= amount
	print("Player health left: ",life)
	if life <= 0:
		print("PLAYER DIED")
		queue_free()
