extends Node2D
class_name EnemySpawner

var enemy_pool
var spawn_count = 10
var enemy_health_scaling_modifier = 1.0
var enemy_damage_scaling_modifier = 1.0
var enemy_speed_scaling_modifier = 1.0

func _ready():
	enemy_pool = EnemyPool.new()


func _on_elite_spawn_timer_timeout():
	var player = Globals.player
	var viewport_size = get_viewport().size
	var spawn_distance = pow(pow(viewport_size.x, 2) + pow(viewport_size.y, 2), 1/2.0) /2
	var spawn_direction = Vector2(0,1).rotated(randf_range(0,2*PI))
	var spawn_location = (spawn_direction * spawn_distance) + player.position
	
	var new_enemy = enemy_pool.get_enemy_array().pick_random().instantiate()
	add_sibling(new_enemy)
	new_enemy.position = spawn_location
	new_enemy.make_elite()
	_modify_enemy(new_enemy)
	

func _on_spawn_timer_timeout():
	var player = Globals.player
	$SpawnTimer.wait_time = 5
	for i in spawn_count:
		var viewport_size = get_viewport().size
		var spawn_distance = pow(pow(viewport_size.x, 2) + pow(viewport_size.y, 2), 1/2.0) /2
		var spawn_direction = Vector2(0,1).rotated(randf_range(0,2*PI))
		var spawn_location = (spawn_direction * spawn_distance) + player.position
		
		var new_enemy = enemy_pool.get_enemy_array().pick_random().instantiate()
		add_sibling(new_enemy)
		_modify_enemy(new_enemy)
		new_enemy.position = spawn_location


func _on_difficulty_scaling_timer_timeout():
	enemy_health_scaling_modifier *= 1.1
	enemy_damage_scaling_modifier *= 1.1
	enemy_speed_scaling_modifier *= 1.1

func _modify_enemy(enemy):
	var modifier_dict = {
		health_modifier = enemy_health_scaling_modifier,
		damage_modifier = enemy_damage_scaling_modifier,
		speed_modifier = enemy_speed_scaling_modifier
	}
	enemy.modify_stats(modifier_dict)
