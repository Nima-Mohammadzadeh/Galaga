extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Level/main_level.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Level/main_menu.tscn")
	

func _on_button_3_pressed():
	get_tree().quit()
