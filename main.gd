extends Node

@onready var path = $Path2D/PathFollow2D
@onready var player = $Player

var enemy = preload("res://Enemies/base_monster.tscn")

func _ready():
	pass

func _process(delta):
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.movement_direction = enemy.position.angle_to_point(player.position) + PI/2


func _on_timer_timeout():
	path.progress_ratio = randf()
	var new_enemy = enemy.instantiate()
	add_child(new_enemy)
	new_enemy.position = path.position
	
