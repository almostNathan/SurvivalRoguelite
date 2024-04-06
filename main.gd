extends Node
class_name MainScene

signal menu_button_pressed

@onready var player = $Player

var spawn_count = 20


#var slime = preload("res://Enemies/Slime/slime.tscn")
#var mushroom = preload("res://Enemies/Mushroom/mushroom.tscn")



func _ready():
	Globals.main_scene = self


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

func get_level_size():
	return $Background.size

func _on_player_ready():
	get_tree().paused = true

func reset_game():
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
		remove_child(turret)
		turret.queue_free()

	player.reset_player()
	Hud.open_weapon_config()
