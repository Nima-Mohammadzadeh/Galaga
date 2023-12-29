extends Area2D

var pBulletEffect := preload("res://Projectiles/bullet_effect.tscn")

var speed = 200 
func _ready():
	add_to_group("enemyBullet")

func _process(delta):
	position.y += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_Enemy_bullet_body_entered(body):
	if body.is_in_group("player"):
		var BulletEffect = pBulletEffect.instantiate()
		BulletEffect.position = position
		get_parent().add_child(BulletEffect)
		body.damage(1)
		queue_free()
