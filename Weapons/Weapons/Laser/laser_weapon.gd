extends BaseWeapon
class_name LaserWeapon

func _init():
	icon = preload("res://Art/Weapons/laser_bullet.png")
	base_damage = 2
	base_attack_speed = 1.0
	current_damage = base_damage
	shooting_angle = PI/2


func _on_weapon_timer_timeout():
	var aiming_direction :float= Vector2.RIGHT.angle_to(player.aiming_direction)
	left_shooting_angle = aiming_direction + (shooting_angle/2)
	angle_between_bullets = shooting_angle / (projectile_count + 1)

	for i in range(projectile_count):
		var new_bullet = bullet_scene.instantiate()
		new_bullet.set_weapon(self)
		player.add_sibling(new_bullet)
		new_bullet.set_player(player)
		shooting_weapon.emit(new_bullet)
		modify_bullet(new_bullet)
		new_bullet.global_position = get_parent().position
		set_bullet_aiming(new_bullet, i, aiming_direction)

func set_bullet_aiming(new_bullet, bullet_number, aiming_direction):
	bullet_number += 1
	new_bullet.rotate(left_shooting_angle - (bullet_number*angle_between_bullets))
