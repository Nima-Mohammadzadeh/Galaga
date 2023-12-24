#Bullet
extends Area2D

const speed = 800
var direction = Vector2.UP

func _ready():
	add_to_group("bullet")

func _process(delta):
	position += direction * speed * delta



func _on_Bullet_area_entered(area):
	if area.is_in_group("damagable"):
		print("Bullet hit enemy!")
		area.damage(1)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
