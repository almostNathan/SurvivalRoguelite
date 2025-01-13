extends BaseWeapon
class_name BoomerangWeapon

#alternative Idea
#Have the boomerang pierce everything but only for one loop

func _init():
	icon = preload("res://Art/Weapons/boomerang_bullet.png")
	tooltip_text = 'Boomerang'
	base_damage = 4
	base_attack_speed = 1
	current_damage = base_damage
	shooting_angle = PI/2
	bounce_value = 2




