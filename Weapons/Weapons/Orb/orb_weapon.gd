extends BaseWeapon
class_name OrbWeapon

var bullet_array : Array[OrbBullet] = []

func _init():
	icon = preload("res://Art/basicterrain/stone.png")
	tooltip_text = 'Orb'
	base_damage = 10
	base_attack_speed = 2
	current_damage = base_damage
	shooting_angle = PI*2
	is_melee = false
	base_attack_speed = .1


func _on_weapon_timer_timeout():
	for i in range(projectile_count):
		var new_bullet = create_new_bullet()
		new_bullet.set_weapon(self)
		player.add_sibling(new_bullet)
		new_bullet.set_player(player)
		new_bullet.rotate(2 * PI * (float(i+1)/projectile_count))
		shooting_weapon.emit(new_bullet)
		modify_bullet(new_bullet)
		new_bullet.global_position = player.position

		bullet_array.append(new_bullet)

func refresh_mods():
	damage_mod.refresh()
	for bullet in bullet_array:
		bullet.queue_free()
	
	bullet_array=[]
	for mod in mod_list:
		if mod is BaseMod:
			mod.refresh()
	weapon_timer.start()
