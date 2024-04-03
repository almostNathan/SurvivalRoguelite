extends BaseWeapon
class_name TurretWeapon

@onready var lifespan_timer = $LifespanTimer
@onready var deploy_timer = $DeployTimer
var primary_turret_weapon : TurretWeapon
var base_deploy_time = 5


func _ready():
	deploy_timer.wait_time = base_deploy_time
	if get_parent() is Player:
		player = get_parent()


func _init():
	icon = preload("res://Art/Weapons/turret_weapon.png")
	base_damage = 4
	base_attack_speed = 1
	current_damage = base_damage
	shooting_angle = PI/2

func _on_deploy_timer_timeout():
	var new_turret : TurretWeapon = self._clone()
	player.add_sibling(new_turret)
	new_turret.player = player
	new_turret.position = player.position
	new_turret.show_weapon_image()
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
	for mod in mod_list:
		new_turret.add_mod(mod.duplicate())
	return new_turret


func _on_lifespan_timer_timeout():
	queue_free()

func set_primary_turret_weapon(turret_weapon:TurretWeapon):
	self.primary_turret_weapon = turret_weapon

func calc_attack_speed():
	super()
	deploy_timer.wait_time = (base_deploy_time + attack_speed_modifier_add) / attack_speed_modifier_mult



