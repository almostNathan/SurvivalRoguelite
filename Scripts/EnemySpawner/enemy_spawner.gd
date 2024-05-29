extends Node2D
class_name EnemySpawner

@onready var spawn_timer : Timer = $SpawnTimer
@onready var elite_spawn_timer : Timer = $EliteSpawnTimer


var enemy_pool
var spawn_count = 1
var spawn_speed = 10.0
var enemy_health_modifier = 1.0
var enemy_damage_modifier = 1.0
var enemy_speed_modifier = 1.0

var enemy_health_scaling_value = 1.1
var enemy_damage_scaling_value = 1.1
var enemy_speed_scaling_value = 1.03

var current_level_number = 0


func _ready():
	enemy_pool = Levels.level_data_list[current_level_number].enemy_pool


func _on_elite_spawn_timer_timeout():
	var player = Globals.player
	var viewport_size = get_viewport().size
	var spawn_distance = pow(pow(viewport_size.x, 2) + pow(viewport_size.y, 2), 1/2.0) /2
	var spawn_direction = Vector2(0,1).rotated(randf_range(0,2*PI))
	var spawn_location = (spawn_direction * spawn_distance) + player.position

	var new_enemy = enemy_pool.pick_random().instantiate()
	add_sibling(new_enemy)
	new_enemy.position = spawn_location
	new_enemy.make_elite()
	_modify_enemy(new_enemy)

func _on_spawn_timer_timeout():
	var player = Globals.player
	spawn_count += 5
	spawn_timer.wait_time = spawn_speed
	for i in spawn_count:
		var viewport_size = get_viewport().size
		var spawn_distance = pow(pow(viewport_size.x, 2) + pow(viewport_size.y, 2), 1/2.0) /2
		var spawn_direction = Vector2(0,1).rotated(randf_range(0,2*PI))
		var spawn_location = (spawn_direction * spawn_distance) + player.position
		
		var new_enemy = enemy_pool.pick_random().instantiate()
		add_sibling(new_enemy)
		_modify_enemy(new_enemy)
		new_enemy.position = spawn_location


func _on_difficulty_scaling_timer_timeout():
	enemy_health_modifier *= enemy_health_scaling_value
	enemy_damage_modifier *= enemy_damage_scaling_value
	enemy_speed_modifier *= enemy_speed_scaling_value

func _modify_enemy(enemy):
	var modifier_dict = {
		health_modifier = enemy_health_modifier,
		damage_modifier = enemy_damage_modifier,
		speed_modifier = enemy_speed_modifier
	}
	enemy.modify_stats(modifier_dict)


func reset_scaling():
	enemy_health_modifier = 1.0
	enemy_damage_modifier = 1.0
	enemy_speed_modifier = 1.0
	spawn_count = 10


func spawn_boss():
	spawn_timer.stop()
	elite_spawn_timer.stop()
	var player = Globals.player
	var viewport_size = get_viewport().size
	
	var spawn_distance = pow(pow(viewport_size.x, 2) + pow(viewport_size.y, 2), 1/2.0) /4
	var spawn_direction = Vector2(0,1).rotated(randf_range(0,2*PI))
	var spawn_location = (spawn_direction * spawn_distance) + player.position
	
	var boss = EnemyPool.boss_pool.pick_random().instantiate()
	
	
	add_sibling(boss)
	boss.position = spawn_location
	_modify_enemy(boss)
	
	
	##Spawn 5 elites instead of boss
	#for i in range(5):
		#var spawn_distance = pow(pow(viewport_size.x, 2) + pow(viewport_size.y, 2), 1/2.0) /2
		#var spawn_direction = Vector2(0,1).rotated(randf_range(0,2*PI))
		#var spawn_location = (spawn_direction * spawn_distance) + player.position
		#
		#var new_enemy = enemy_pool.pick_random().instantiate()
		#add_sibling(new_enemy)
		#new_enemy.position = spawn_location
		#new_enemy.make_elite()
		#var modifier_dict = {
		#health_modifier = enemy_health_modifier*2,
		#damage_modifier = enemy_damage_modifier,
		#speed_modifier = enemy_speed_modifier
		#}
		#new_enemy.modify_stats(modifier_dict)


func change_level(new_level_number):
	current_level_number = new_level_number
	enemy_pool = Levels.level_data_list[current_level_number].enemy_pool
	spawn_timer.start()
	elite_spawn_timer.start()
	
