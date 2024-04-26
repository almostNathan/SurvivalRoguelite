extends BaseWeapon
class_name MagicBookWeapon

func _init():
	icon = preload("res://Art/Weapons/fireballs/meteor_side_medium/imgs/img_1.png")
	base_damage = 10
	current_damage = base_damage
	base_attack_speed = 1.5


func set_bullet_aiming(new_bullet, _bullet_number, _aiming_direction):
	var enemies = get_tree().get_nodes_in_group("enemy")
	var targetable_enemies : Array = []
	for enemy in enemies:
		if enemy.position.distance_to(player.position) < 600:
			targetable_enemies.append(enemy)
	
	if len(targetable_enemies) == 0:
		new_bullet.queue_free()
	var random_enemy = targetable_enemies.pick_random()
	if random_enemy != null:
		new_bullet.target_position = random_enemy.position
		new_bullet.rotation = player.get_angle_to(random_enemy.position)


