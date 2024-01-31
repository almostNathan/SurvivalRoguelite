extends BaseWeapon
class_name StoneWeapon



func _ready():
	super()
	base_damage = 7
	current_damage = base_damage
	shooting_angle = PI/2
	add_mod(preload("res://Weapons/Mods/AddProj/add_proj_mod.tscn").instantiate())
	add_mod(preload("res://Weapons/Mods/AddProj/add_proj_mod.tscn").instantiate())

func set_bullet_aiming(new_bullet, bullet_number, aiming_direction):
	new_bullet.set_movement_direction(Vector2.RIGHT.rotated(randf_range(aiming_direction-(shooting_angle/2), aiming_direction + (shooting_angle/2))))


func modify_bullet(bullet_proto):
	bullet_proto.speed = randf_range(400, 600)
