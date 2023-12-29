extends Area2D

var BULLET: PackedScene = preload("res://Projectiles/enemy_bullet.tscn")
@onready var bullet_location = $marker2d
@onready var shoot_timer = $Timer
var ready_to_shoot = true


@export var score_for_kill: int = 100
@export var speed = 100
@export var life: int = 1


const LEFT_BOUNDARY = 57
const RIGHT_BOUNDARY = 1251
const TOP_BOUNDARY = 50
const BOTTOM_BOUNDARY = 300

var moving_right = true

#Creating enemy random movement
#WORK IN PROGRESS
var directions = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
var currentDirection = Vector2.ZERO


func _ready():
	add_to_group("damagable")
	
func shoot(): 
	var b = BULLET.instantiate()
	b.position = bullet_location.global_position
	get_parent().add_child(b)
	shoot_timer.start()
	
func _process(delta):
#shoot with a delay back at the player
	if currentDirection == Vector2.ZERO or randf() < 0.01: 
		currentDirection = directions[randi() % directions.size()]
	position += currentDirection * speed * delta

#Have the enemy move right until the screen boundry is hit
	if position.x < LEFT_BOUNDARY and currentDirection.x < 0:
		currentDirection.x = 1
	elif position.x > RIGHT_BOUNDARY and currentDirection.x > 0:
		currentDirection.x = -1
	if position.y < TOP_BOUNDARY and currentDirection.y < 0:  # Assuming a TOP_BOUNDARY is defined
		currentDirection.y = 1
	elif position.y > BOTTOM_BOUNDARY and currentDirection.y > 0:  # Assuming a BOTTOM_BOUNDARY is defined
		currentDirection.y = -1
		
		
	if shoot_timer.is_stopped() and ready_to_shoot:
		shoot()
		

func damage(amount: int):
	life -= amount
	if life <= 0:
		
		Signals.emit_signal("on_score_change",score_for_kill)
		$DeathSound.play()
		hide()
		remove_from_group("damagable")
		shoot_timer.stop()
		ready_to_shoot = false
		var timer = Timer.new()
		timer.wait_time = $DeathSound.stream.get_length()
		timer.one_shot = true
		timer.connect("timeout", Callable(self, "queue_free"))
		add_child(timer)
		timer.start()
		
		

func _on_body_entered(body):
	if body is Player:
		body.damage(1)
