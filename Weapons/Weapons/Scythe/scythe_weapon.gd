extends BaseWeapon
class_name ScytheWeapon

var lead_in_angle = PI/2

func _init():
	base_damage = 4
	current_damage = base_damage
	shooting_angle = PI*2


func set_bullet_aiming(new_bullet, bullet_number, aiming_direction):
	angle_between_bullets = shooting_angle / projectile_count
	new_bullet.rotate(aiming_direction + (bullet_number*angle_between_bullets) - lead_in_angle)

