extends Node

@onready var path = $Path2D/PathFollow2D
@onready var player = $Player
@onready var health_bar = $Player/HealthBar

#var slime = preload("res://Enemies/Slime/slime.tscn")
#var mushroom = preload("res://Enemies/Mushroom/mushroom.tscn")

@onready var monster_pool : MonsterPool

func _ready():
	monster_pool = MonsterPool.new()

func _process(_delta):
	var enemies = get_tree().get_nodes_in_group("enemy")
	#point all enemies at the player
	for enemy in enemies:
		enemy.set_movement_direction(enemy.position.angle_to_point(player.position) + PI/2)


func _on_timer_timeout():
	path.progress_ratio = randf()
	var new_enemy = monster_pool.get_monster_array().pick_random().instantiate()
	add_child(new_enemy)
	new_enemy.position = path.position
	


func _on_player_health_changed(cur_health):
	health_bar.value = cur_health

func get_level_size():
	return $Background.size
