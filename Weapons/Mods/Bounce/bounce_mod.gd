extends BaseMod
class_name BounceMod

var bounce_modifier = 1

func set_base_data():

	mod_name = "Bounce"
	icon = preload("res://Art/Drops/bounce_mod.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.on_hit.connect(_on_hit)
	weapon.bounce_value += bounce_modifier

func get_tooltip_description():
	var description
	if bounce_modifier == 1:
		description ="Projectiles from weapon bounce "+ str(bounce_modifier) +" additional time\n"
	else:
		description ="Projectiles from weapon bounce "+ str(bounce_modifier) +" additional times\n"
	
	tooltip_description = "[center][b]" + mod_name + "[/b][/center]\n" \
			+ "[center]" + description + "[/center]\n"
	return tooltip_description


func _on_hit(_body, bullet):
	if weapon != null:
		if weapon.is_melee == true:
			bullet.delete_bullet = false
			bullet.enemies_bounced += 1
			bullet.rotation_speed *= -1
		if  bullet is BaseBullet && bullet.enemies_bounced < weapon.bounce_value && bullet.delete_bullet == true:
			bullet.delete_bullet = false
			bullet.enemies_bounced += 1
			bullet.modify_movement_direction(PI)


func refresh():
	if weapon != null:
		weapon.bounce_value -= bounce_modifier
		bounce_modifier = current_rank
		weapon.bounce_value += bounce_modifier
	else:
		bounce_modifier = current_rank

func remove_mod():
	super()
	weapon.bounce_value -= bounce_modifier
	weapon.on_hit.disconnect(_on_hit)
