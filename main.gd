extends Node
class_name MainScene

signal menu_button_pressed

@onready var player = $Player
@onready var enemy_spawner : EnemySpawner = $EnemySpawner
@onready var background : ColorRect = $Background
@onready var level_timer : Timer = $LevelTimer

var spawn_count = 20
var is_boss_spawned = false
var is_portal_spawned = false
var current_level_number = 0
var current_level_portal


func _ready():
	Globals.main_scene = self
	background.color = Levels.level_data_list[current_level_number].background_color
	

func _process(_delta):
	$Background.position = player.position - Vector2((get_viewport().size/2))
	
	#TODO Create node to handle enemy movement
	var enemies = get_tree().get_nodes_in_group("enemy")

	#point all enemies at the player
	var closest_enemy_position = Vector2(0,0)
	for enemy in enemies:
		enemy.set_movement_direction(enemy.position.angle_to_point(player.position) + PI/2)
		if (player.position.distance_to(enemy.position) < player.position.distance_to(closest_enemy_position) 
			or closest_enemy_position == Vector2(0,0)):
			closest_enemy_position = enemy.position
	player.set_aiming_direction(closest_enemy_position)
	
	if is_boss_spawned and len(enemies) == 0 and ! is_portal_spawned:
		spawn_portal()

func get_level_size():
	return $Background.size

func _on_player_ready():
	get_tree().paused = true

func reset_game():
	clear_level()

	is_boss_spawned = false
	is_portal_spawned = false
	player.reset_player()
	Hud.open_weapon_config()
	enemy_spawner.reset_scaling() 
	current_level_number = 0
	background.color = Levels.level_data_list[0].background_color
	get_tree().change_scene_to_file("res://UI/StartMenu/start_menu.tscn")

func clear_level():
	is_boss_spawned = false
	is_portal_spawned = false
	var enemies = get_tree().get_nodes_in_group("enemy")
	var pickups = get_tree().get_nodes_in_group("pickups")
	var bullets = get_tree().get_nodes_in_group("bullet")
	var turrets = get_tree().get_nodes_in_group("turret")
	for enemy in enemies:
		remove_child(enemy)
		enemy.queue_free()
	for pickup in pickups:
		remove_child(pickup)
		pickup.queue_free()
	for bullet in bullets:
		remove_child(bullet)
		bullet.queue_free()
	for turret in turrets:
		for child in get_children():
			if turret == child:
				remove_child(turret)
				turret.queue_free()
	level_timer.start()

func _on_level_timer_timeout():
	enemy_spawner.spawn_boss()
	is_boss_spawned = true

func spawn_portal():
	is_portal_spawned = true
	current_level_portal = preload("res://Levels/level_portal.tscn").instantiate()
	add_child(current_level_portal)
	current_level_portal.position = player.position + Vector2(100, 0)
	current_level_portal.next_level.connect(go_to_next_level)

func go_to_next_level():
	clear_level()
	current_level_number += 1
	
	var available_loot_scene_list = AllWeaponList.weapon_scene_list.duplicate()
	for weapon_scene in available_loot_scene_list:
		for weapon in Globals.player.weapon_inventory:
			if weapon_scene.instantiate().name == weapon.name:
				available_loot_scene_list.remove_at(available_loot_scene_list.find(weapon_scene))
	
	Hud.load_loot_menu(available_loot_scene_list)
	
	
	background.color = Levels.level_data_list[current_level_number].background_color
	enemy_spawner.change_level(current_level_number)
	level_timer.start()
