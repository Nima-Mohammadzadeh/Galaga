extends CharacterBody2D

# speed and screen constraints
const SPEED = 300.0
const LEFT_BOUNDARY = 57
const RIGHT_BOUNDARY = 1221

var BULLET: PackedScene = preload("res://Projectiles/bullet.tscn")
@onready var bullet_marker = $Marker2D
@onready var shoot_timer = $ShotTimer


func shoot():
	var b = BULLET.instantiate()
	b.position = bullet_marker.global_position
	get_parent().add_child(b)
	

#shooting of ship
func _input(event):	
	if Input.is_action_pressed("shoot"):
		shoot()

#check user for input of ship
func _process(delta):
	if Input.is_action_pressed("right"):
		position.x += SPEED * delta
	if Input.is_action_pressed("left"):
		position.x -= SPEED * delta
		
	# Constrain the spaceship within the boundaries
	position.x = clamp(position.x, LEFT_BOUNDARY, RIGHT_BOUNDARY)

