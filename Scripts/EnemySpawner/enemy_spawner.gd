extends Node2D
class_name EnemySpawner

@onready var spawn_timer : Timer = $SpawnTimer
@onready var elite_spawn_timer : Timer = $EliteSpawnTimer
@onready var difficulty_scaling_timer : Timer = $DifficultyScalingTimer

var spawner_on = false

var enemy_pool
var spawn_count = 1
var spawn_speed = 10.0
var total_value_spawned = 0
var current_spawn_power = 500
var spawn_power_scaling_value = 1.05

var enemy_health_modifier = 1.0
var enemy_damage_modifier = 1.0
var enemy_speed_modifier = 1.0

var enemy_health_scaling_value = 1.1
var enemy_damage_scaling_value = 1.01
var enemy_speed_scaling_value = 1.03

var current_level_number = 0

###Spawning Variables
var viewport_size : Vector2
var spawn_distance

func _ready():
	viewport_size = get_viewport().size
	spawn_distance = pow(pow(viewport_size.x, 2) + pow(viewport_size.y, 2), 1/2.0) /2
	enemy_pool = Levels.level_data_list[current_level_number].enemy_pool

func _process(delta):
	var player = Globals.player
	total_value_spawned = 0
	
	#get total value currently spawned
	for enemy in get_tree().get_nodes_in_group("enemy"):
		total_value_spawned += enemy.spawn_value
	#spawn up to max value
	if total_value_spawned < current_spawn_power  && spawner_on:
		var spawn_direction = Vector2(0,1).rotated(randf_range(0,2*PI))
		var spawn_location = (spawn_direction * spawn_distance) + player.position
		
		var new_enemy = enemy_pool.pick_random().instantiate()
		new_enemy.position = spawn_location
		var spawn_data = {'enemy':new_enemy, "position":spawn_location}
		spawn_enemy(spawn_data)
		#add_sibling(new_enemy)
		#_modify_enemy(new_enemy)
		#total_value_spawned += new_enemy.spawn_value
		

func spawn_enemy(spawn_data:Dictionary):
	var player = Globals.player
	var new_enemy = spawn_data['enemy']
	var retry_vector = player.position.angle_to(new_enemy.position)
	add_sibling(new_enemy)
	_modify_enemy(new_enemy)
	var not_colliding = true
	while not_colliding:
		var collision = new_enemy.move_and_collide(Vector2(0,0))
		if collision != null and collision.get_collider() is TileMap:
			new_enemy.position += Vector2(50,0).rotated(retry_vector)
		else:
			not_colliding = false
	

	total_value_spawned += new_enemy.spawn_value

func _on_elite_spawn_timer_timeout():
	var player = Globals.player
	var viewport_size = get_viewport().size
	var spawn_distance = pow(pow(viewport_size.x, 2) + pow(viewport_size.y, 2), 1/2.0) /2
	var spawn_direction = Vector2(0,1).rotated(randf_range(0,2*PI))
	var spawn_location = (spawn_direction * spawn_distance) + player.position

	var new_enemy = enemy_pool.pick_random().instantiate()
	new_enemy.position = spawn_location
	add_sibling(new_enemy)
	new_enemy.make_elite()
	_modify_enemy(new_enemy)

func _on_spawn_timer_timeout():
	spawner_on = true
	current_spawn_power *= spawn_power_scaling_value
	
	#var player = Globals.player
	#var total_value_spawned = 0
	#spawn_count += 5
	#spawn_timer.wait_time = spawn_speed
	#while total_value_spawned < current_spawn_power:
		#var new_enemy = enemy_pool.pick_random().instantiate()
		#var spawn_location = get_new_spawn_location(player.position)
		#var not_colliding = true
		#while not_colliding:
			#var collision = new_enemy.move_and_collide(Vector2(0,0))
			#if collision != null and collision.get_collider() is TileMap:
				#spawn_location = get_new_spawn_location(player.position)
			#else:
				#not_colliding = false
		#var spawn_data = {'enemy':new_enemy, "position":spawn_location}
		#spawn_enemy(spawn_data)
		#add_sibling(new_enemy)
		#_modify_enemy(new_enemy)
		#total_value_spawned += new_enemy.spawn_value

func spawn_group(enemy_list: Array, direction_to_spawn):
	pass

func get_new_spawn_location(player_position):
	var viewport_size = get_viewport().size
	var spawn_distance = pow(pow(viewport_size.x, 2) + pow(viewport_size.y, 2), 1/2.0) /2
	var spawn_direction = Vector2(0,1).rotated(randf_range(0,2*PI))
	var spawn_location = (spawn_direction * spawn_distance) + player_position
	
	return spawn_location


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
	spawner_on = false
	spawn_timer.stop()
	elite_spawn_timer.stop()
	difficulty_scaling_timer.stop()
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
	difficulty_scaling_timer.start()
	
