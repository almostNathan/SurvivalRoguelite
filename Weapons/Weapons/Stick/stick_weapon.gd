extends BaseWeapon
class_name StickWeapon


func _ready():
	super()
	base_damage = 50
	current_damage = base_damage
	shooting_angle = PI*2
	

	
func set_bullet_aiming(new_bullet, bullet_number, aiming_direction):
	angle_between_bullets =shooting_angle / projectile_count
	new_bullet.rotate(aiming_direction + (bullet_number*angle_between_bullets))

