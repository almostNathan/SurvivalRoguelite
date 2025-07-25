extends BaseWeapon
class_name StoneWeapon

func _init():
	icon = preload("res://Art/basicterrain/stone.png")
	tooltip_text = 'Stone'
	weapon_name = "Stone"
	base_damage = 6
	base_attack_speed = 1
	current_damage = base_damage
	shooting_angle = PI/2
	projectile_count = 3
	speed = 500

func set_bullet_aiming(new_bullet, _bullet_number, aiming_direction):
	new_bullet.set_movement_direction(Vector2.RIGHT.rotated(randf_range(aiming_direction-(shooting_angle/2), aiming_direction + (shooting_angle/2))))


func modify_bullet(bullet_proto):
	super(bullet_proto)
	var total_speed = speed * projectile_speed_modifier_mult
	bullet_proto.speed = randf_range(total_speed-100, total_speed+100)
