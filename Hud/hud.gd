extends Control

@onready var lifeContainer = $LifeContainer
var pLifeIcon := preload("res://Hud/life_icon.tscn")
var score := 0
# Called when the node enters the scene tree for the first time.
func _ready():
	clearlives()
	
	Signals.on_player_life_changed.connect(Callable(self, "_on_player_life_changed"))
	Signals.on_score_change.connect(Callable(self, "_on_score_change"))
	
func clearlives():
	for child in lifeContainer.get_children():
		lifeContainer.remove_child(child)
		child.queue_free()

func setLives(lives: int):
	clearlives()
	for i in range(lives):
		lifeContainer.add_child(pLifeIcon.instantiate())
		
func setScore(score_to_change_by: int):
	get_node("Score").text = str(score)
	
func _on_player_life_changed(life: int):
	setLives(life)

func _on_score_change(score_for_kill: int):
	score += score_for_kill
	setScore(score)
	
	

