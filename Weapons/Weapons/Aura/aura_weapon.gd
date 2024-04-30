extends BaseWeapon
class_name AuraWeapon


func _init():
	icon = preload("res://Art/Weapons/aura_bullet.png")
	tooltip_text = 'Aura'
	base_damage = 2
	base_attack_speed = .25
	current_damage = base_damage
	shooting_angle = PI/2


func _on_weapon_timer_timeout():
	var new_bullet = bullet_scene.instantiate()
	new_bullet.hit_count = projectile_count
	new_bullet.set_weapon(self)
	get_parent().add_sibling(new_bullet)
	new_bullet.set_player(player)
	shooting_weapon.emit(new_bullet)
	modify_bullet(new_bullet)
	new_bullet.global_position = get_parent().position
