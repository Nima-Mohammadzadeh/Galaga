extends Area2D

var speed = 100
const LEFT_BOUNDARY = 57
const RIGHT_BOUNDARY = 1251
var moving_right = true


var BULLET: PackedScene = preload("res://Projectiles/enemy_bullet.tscn")
@onready var bullet_location = $marker2d
@onready var shoot_timer = $Timer


func shoot(): 
	var b = BULLET.instantiate()
	b.position = bullet_location.global_position
	get_parent().add_child(b)
	shoot_timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#Have the enemy move right until the screen boundry is hit
	if (moving_right):
		position.x += speed * delta
		if(position.x >= RIGHT_BOUNDARY):
			moving_right = false
	else:
#Move left if enemy can no longer move right
		position.x -= speed * delta
		if(position.x <= LEFT_BOUNDARY):
			moving_right = true
	position.x = clamp(position.x, LEFT_BOUNDARY, RIGHT_BOUNDARY)
	if shoot_timer.is_stopped():
		shoot()
