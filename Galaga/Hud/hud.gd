extends Control

@onready var lifeContainer = $LifeContainer
var pLifeIcon := preload("res://Hud/life_icon.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	clearlives()
	
	Signals.on_player_life_changed.connect(Callable(self, "_on_player_life_changed"))
	
func clearlives():
	for child in lifeContainer.get_children():
		lifeContainer.remove_child(child)
		child.queue_free()

func setLives(lives: int):
	clearlives()
	for i in range(lives):
		lifeContainer.add_child(pLifeIcon.instantiate())
	
func _on_player_life_changed(life: int):
	setLives(life)
