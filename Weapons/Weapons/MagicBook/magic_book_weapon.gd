extends BaseWeapon
class_name MagicBookWeapon

func set_bullet_aiming(new_bullet, bullet_number, aiming_direction):
	var enemies = get_tree().get_nodes_in_group("enemy")
	var random_enemy = enemies.pick_random()
	new_bullet.target_location = random_enemy.position
	new_bullet.rotation = player.get_angle_to(random_enemy.position)


