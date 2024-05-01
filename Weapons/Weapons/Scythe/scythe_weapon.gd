extends BaseWeapon
class_name ScytheWeapon

var lead_in_angle = PI/2


func _init():
	icon = preload("res://Art/Weapons/scythe.png")
	tooltip_text = 'Scythe'
	base_damage = 4
	base_attack_speed = 2
	current_damage = base_damage
	shooting_angle = PI*2
	pierce_value = 1
	is_melee = true



func set_bullet_aiming(new_bullet, bullet_number, aiming_direction):
	angle_between_bullets = shooting_angle / projectile_count
	new_bullet.rotate(aiming_direction + (bullet_number*angle_between_bullets) - lead_in_angle)

