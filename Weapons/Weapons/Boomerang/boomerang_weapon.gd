extends BaseWeapon
class_name BoomerangWeapon

#alternative Idea
#Have the boomerang pierce everything but only for one loop

func _init():
	icon = preload("res://Art/Weapons/boomerang_bullet.png")
	base_damage = 4
	base_attack_speed = 1
	current_damage = base_damage
	shooting_angle = PI/2
	bounce_value = 2

func _ready():
	super()
	#add_mod(preload("res://Weapons/Mods/Bounce/bounce_mod.tscn").instantiate())
	#add_mod(preload("res://Weapons/Mods/Bounce/bounce_mod.tscn").instantiate())



