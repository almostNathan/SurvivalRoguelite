extends BulletMod
class_name AttackSpeedMod

var attack_speed_mult = .15

func _init():
	tooltip_text = "Attack Speed"
	icon = preload("res://Art/Drops/knockback_mod.png")

func _ready():
	super()
	parent.modify_attack_speed_mult(attack_speed_mult)

func rank_up():
	attack_speed_mult += .15
	if parent != null:
		parent.modify_attack_speed_mult(attack_speed_mult)

