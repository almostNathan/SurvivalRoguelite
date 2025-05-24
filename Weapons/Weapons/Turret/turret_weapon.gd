extends BaseWeapon
class_name TurretWeapon

@onready var lifespan_timer = $LifespanTimer
@onready var deploy_timer = $DeployTimer
var primary_turret_weapon : TurretWeapon
var base_deploy_time = 5
var deploy_speed_modifier_add = 0
var deploy_speed_modifier_mult = 1
var base_lifespan_time = 10
var current_lifespan_time = base_lifespan_time


func _ready():
	deploy_timer.wait_time = base_deploy_time
	if get_parent() is Player:
		player = get_parent()
	damage_mod = damage_mod_scene.instantiate()
	damage_mod.equip(self)


func _init():
	icon = preload("res://Art/Weapons/turret_weapon.png")
	tooltip_text = 'Turret'
	base_damage = 4
	base_attack_speed = 1
	current_damage = base_damage
	shooting_angle = PI/2

func _on_deploy_timer_timeout():
	var new_turret : TurretWeapon = self._clone()
	new_turret.player = player
	new_turret.position = player.position
	new_turret.show_weapon_image()
	new_turret
	new_turret.lifespan_timer.start()
	new_turret.weapon_timer.start()
	new_turret.deploy_timer.stop()
	new_turret.set_primary_turret_weapon(self)


func set_bullet_aiming(new_bullet, bullet_number, _aiming_direction):
	new_bullet.set_weapon(primary_turret_weapon)
	new_bullet.position = self.position
	var enemies = get_tree().get_nodes_in_group("enemy")
	#point all enemies at the player
	var closest_enemy_position = Vector2(0,0)
	for enemy in enemies:
		if (self.position.distance_to(enemy.position) < self.position.distance_to(closest_enemy_position)):
			closest_enemy_position = enemy.position
			
	var angle_to_closest_enemy = position.angle_to_point(closest_enemy_position)
	left_shooting_angle = angle_to_closest_enemy + (shooting_angle/2)
	new_bullet.set_movement_direction(Vector2.RIGHT.rotated(left_shooting_angle - (angle_between_bullets * (bullet_number+1))))


func _clone():
	var new_turret = preload("res://Weapons/Weapons/Turret/turret_weapon.tscn").instantiate()
	player.add_sibling(new_turret)
	var new_mod_list = mod_list.duplicate(true)
	for mod in new_mod_list:
		new_turret.add_mod(mod)
	apply_player_mods_to_weapon(new_turret)
	return new_turret


func _on_lifespan_timer_timeout():
	queue_free()

func set_primary_turret_weapon(turret_weapon:TurretWeapon):
	self.primary_turret_weapon = turret_weapon

func modify_deploy_speed_add(deloy_speed_change):
	deploy_speed_modifier_add += deloy_speed_change
	calc_deploy_speed()

func modify_deploy_speed_mult(deploy_speed_change):
	deploy_speed_modifier_mult += deploy_speed_change
	calc_deploy_speed()

func calc_deploy_speed():
	deploy_timer.wait_time = (base_deploy_time + deploy_speed_modifier_add) / deploy_speed_modifier_mult

func modify_duration_mult(modifier_change):
	super(modifier_change)
	current_lifespan_time = base_lifespan_time * duration_modifier_mult
	lifespan_timer.wait_time = current_lifespan_time
