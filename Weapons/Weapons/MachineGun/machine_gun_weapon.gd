extends BaseWeapon
class_name MachineGunWeapon


func _init():
	icon = preload("res://Art/Weapons/machine_gun_weapon.png")
	tooltip_text = 'Machine Gun'
	weapon_name = "Machine Gun"
	base_damage = 2
	base_attack_speed = .15
	current_damage = base_damage
	shooting_angle = PI/8
