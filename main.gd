extends Node

signal menu_button_pressed

@onready var player = $Player
@onready var health_bar = $Player/HealthBar

var spawn_count = 20


#var slime = preload("res://Enemies/Slime/slime.tscn")
#var mushroom = preload("res://Enemies/Mushroom/mushroom.tscn")

@onready var monster_pool : MonsterPool

func _ready():
	monster_pool = MonsterPool.new()


func _process(_delta):
	$Background.position = player.position - Vector2((get_viewport().size/2))
	var enemies = get_tree().get_nodes_in_group("enemy")
	#point all enemies at the player
	var closest_enemy_position = Vector2(0,0)
	for enemy in enemies:
		enemy.set_movement_direction(enemy.position.angle_to_point(player.position) + PI/2)
		if (player.position.distance_to(enemy.position) < player.position.distance_to(closest_enemy_position)):
			closest_enemy_position = enemy.position
	player.set_aiming_direction(closest_enemy_position)

func _on_player_health_changed(cur_health):
	health_bar.value = cur_health

func get_level_size():
	return $Background.size

func _on_player_ready():
	get_tree().paused = true

func _on_elite_spawn_timer_timeout():
	var viewport_size = get_viewport().size
	var spawn_distance = pow(pow(viewport_size.x, 2) + pow(viewport_size.y, 2), 1/2.0) /2
	var spawn_direction = Vector2(0,1).rotated(randf_range(0,2*PI))
	var spawn_location = (spawn_direction * spawn_distance) + player.position
	
	var new_enemy = monster_pool.get_monster_array().pick_random().instantiate()
	add_child(new_enemy)
	new_enemy.position = spawn_location
	new_enemy.make_elite()

func _on_spawn_timer_timeout():
	$SpawnTimer.wait_time = 5
	for i in spawn_count:
		var viewport_size = get_viewport().size
		var spawn_distance = pow(pow(viewport_size.x, 2) + pow(viewport_size.y, 2), 1/2.0) /2
		var spawn_direction = Vector2(0,1).rotated(randf_range(0,2*PI))
		var spawn_location = (spawn_direction * spawn_distance) + player.position
		print(spawn_distance)
		print(viewport_size)
		
		var new_enemy = monster_pool.get_monster_array().pick_random().instantiate()
		add_child(new_enemy)
		new_enemy.position = spawn_location
