extends Node

@onready var path = $Path2D/PathFollow2D

var enemy = preload("res://Enemies/base_monster.tscn")

func _ready():
	pass

func _process(delta):
	pass


func _on_timer_timeout():
	path.progress_ratio = randf()
	var new_enemy = enemy.instantiate()
	add_child(new_enemy)
	new_enemy.position = path.position
	
