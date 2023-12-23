extends RigidBody2D

var speed = 100
const LEFT_BOUNDARY = 57
const RIGHT_BOUNDARY = 1251
var moving_right = true
var direction = Vector2.DOWN


var BULLET: PackedScene = preload("res://Projectiles/enemy_bullet.tscn")
@onready var bullet_location = $marker2d
@onready var shoot_timer = $Timer

func _ready():
	add_to_group("enemies")
	
func shoot(): 
	var b = BULLET.instantiate()
	b.position = bullet_location.global_position
	get_parent().add_child(b)
	shoot_timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#Have the enemy move right until the screen boundry is hit
	if shoot_timer.is_stopped():
		shoot()
	if moving_right:
		linear_velocity.x = speed
	else:
		linear_velocity.x = -speed
	if position.x >= RIGHT_BOUNDARY and moving_right:
		moving_right = false
	elif position.x <= LEFT_BOUNDARY and not moving_right:
		moving_right = true
	
	



func _on_body_entered(body):
	print("WOOOOORKS")
