extends Area2D


var speed = 200 
func _ready():
	add_to_group("enemyBullet")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
