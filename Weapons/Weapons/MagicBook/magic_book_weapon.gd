extends BaseWeapon
class_name MagicBookWeapon

func _init():
	base_damage = 20
	current_damage = base_damage
	icon = preload("res://Art/Weapons/fireballs/meteor_side_medium/imgs/img_1.png")


func set_bullet_aiming(new_bullet, bullet_number, aiming_direction):
	var enemies = get_tree().get_nodes_in_group("enemy")
	var random_enemy = enemies.pick_random()
	new_bullet.target_position = random_enemy.position
	
	new_bullet.rotation = player.get_angle_to(random_enemy.position)


