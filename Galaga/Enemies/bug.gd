extends Area2D

var BULLET: PackedScene = preload("res://Projectiles/enemy_bullet.tscn")
@onready var bullet_location = $marker2d
@onready var shoot_timer = $Timer


@export var score_for_kill: int = 100
@export var speed = 100
@export var life: int = 1


const LEFT_BOUNDARY = 57
const RIGHT_BOUNDARY = 1251
var moving_right = true


func _ready():
	add_to_group("damagable")
	
func shoot(): 
	var b = BULLET.instantiate()
	b.position = bullet_location.global_position
	get_parent().add_child(b)
	shoot_timer.start()
	
func _process(delta):
#shoot with a delay back at the player
	if shoot_timer.is_stopped():
		shoot()
#Have the enemy move right until the screen boundry is hit
	if moving_right:
		position.x += speed * delta
	else:
		position.x -= speed * delta
	if position.x >= RIGHT_BOUNDARY and moving_right:
		moving_right = false
	elif position.x <= LEFT_BOUNDARY and not moving_right:
		moving_right = true
		

func damage(amount: int):
	life -= amount
	if life <= 0:
		
		Signals.emit_signal("on_score_change",score_for_kill)
		$AudioStreamPlayer2D.play()
		hide()
		var timer = Timer.new()
		timer.wait_time = $AudioStreamPlayer2D.stream.get_length()
		timer.one_shot = true
		timer.connect("timeout", Callable(self, "queue_free"))
		add_child(timer)
		timer.start()
		
		

func _on_body_entered(body):
	if body is Player:
		body.damage(1)
