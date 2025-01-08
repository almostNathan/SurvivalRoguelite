extends BaseMod
class_name PierceMod

var pierce_modifier = 1
var pierces_used = 0


func _init():
	tooltip_text = "Pierce"
	icon = preload("res://Art/Drops/pierce_mod.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.on_hit.connect(_on_hit)
	weapon.pierce_value += pierce_modifier
	

func _on_hit(_body, bullet):
	if weapon != null:
		if bullet is BaseBullet && bullet.enemies_pierced < weapon.pierce_value && bullet.delete_bullet == true:
			bullet.delete_bullet = false
			bullet.enemies_pierced += 1

func refresh():
	if weapon != null:
		weapon.pierce_value -= pierce_modifier
		pierce_modifier = current_rank
		weapon.pierce_value += pierce_modifier
	else:
		pierce_modifier = current_rank

func remove_mod():
	super()
	weapon.pierce_value -= pierce_modifier
	weapon.on_hit.disconnect(_on_hit)



