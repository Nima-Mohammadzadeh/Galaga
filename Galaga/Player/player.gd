extends Area2D

# speed and screen constraints
const SPEED = 300.0
const LEFT_BOUNDARY = 45
const RIGHT_BOUNDARY = 1240
const TOP_BOUNDARY = 50
const BOTTOM_BOUNDARY = 670

var BULLET: PackedScene = preload("res://Projectiles/bullet.tscn")
@onready var bullet_marker = $Marker2D
@onready var shoot_timer = $ShotTimer


func shoot():
	var b = BULLET.instantiate()
	b.position = bullet_marker.global_position
	get_parent().add_child(b)
	shoot_timer.start()

#shooting of ship
func _input(_event):
	if Input.is_action_pressed("shoot") and shoot_timer.is_stopped():
		shoot()

#check user for input of ship
func _process(delta):
	if Input.is_action_pressed("up"):
		position.y -= SPEED * delta
	if Input.is_action_pressed("down"):
		position.y += SPEED * delta
	if Input.is_action_pressed("right"):
		position.x += SPEED * delta
	if Input.is_action_pressed("left"):
		position.x -= SPEED * delta
		
	# Constrain the spaceship within the boundaries
	position.x = clamp(position.x, LEFT_BOUNDARY, RIGHT_BOUNDARY)
	position.y = clamp(position.y, TOP_BOUNDARY, BOTTOM_BOUNDARY)




func _on_area_entered(area):
	if area.is_in_group("enemies"):
		print("collide")
	
