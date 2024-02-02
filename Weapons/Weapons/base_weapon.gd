extends Node2D
class_name BaseWeapon

signal shooting_weapon()
signal off_cooldown(body)
signal on_hit(body)
signal on_kill(body)
signal adding_mod(mod)

@export var bullet_scene : PackedScene
@export var speed = 700.0
@export var base_damage = 20
var current_damage = base_damage

@onready var weapon_image = $Image
@onready var weapon_cooldown : Timer = $WeaponTimer

var available_mod_slots = 0
var current_mod_count = 0
var player : CharacterBody2D
var bullet_proto : BaseBullet

@export var base_attack_speed = 1
var attack_speed_modifier_add = 0
var attack_speed_modifier_mult = 1
var projectile_count = 1
var shooting_angle = PI
var left_shooting_angle
var angle_between_bullets
var bounce_value = 0
var pierce_value = 0

func _ready():
	weapon_cooldown.wait_time = base_attack_speed
	bullet_proto = bullet_scene.instantiate()

	player = get_parent()
	
func modify_bullet(bullet_proto):
	pass

func get_image_texture():
	return weapon_image.texture

func get_cooldown():
	return weapon_cooldown.time_left

func _on_weapon_timer_timeout():
	var aiming_direction :float= Vector2.RIGHT.angle_to(get_parent().aiming_direction)
	
	left_shooting_angle = aiming_direction + (shooting_angle/2)
	angle_between_bullets = shooting_angle / (projectile_count + 1)

	
	for i in range(projectile_count):
		var new_bullet = bullet_scene.instantiate()
		new_bullet.set_weapon(self)
		get_parent().add_sibling(new_bullet)
		new_bullet.set_player(player)
		shooting_weapon.emit(new_bullet)
		modify_bullet(new_bullet)
		new_bullet.global_position = get_parent().position
		set_bullet_aiming(new_bullet, i, aiming_direction)

func set_bullet_aiming(new_bullet, bullet_number, aiming_direction):
	new_bullet.set_movement_direction(Vector2.RIGHT.rotated(left_shooting_angle - (angle_between_bullets * (bullet_number+1))))


func modify_attack_speed_add(attack_speed_change):
	attack_speed_modifier_add += attack_speed_change
	calc_attack_speed()

func modify_attack_speed_mult(attack_speed_change):
	attack_speed_modifier_mult += attack_speed_change
	calc_attack_speed()

func calc_attack_speed():
	weapon_cooldown.wait_time = (base_attack_speed + attack_speed_modifier_add) / attack_speed_modifier_mult

func modify_damage_add(damage_change):
	current_damage += damage_change
	refresh_mods()

func modify_damage_mult(damage_change):
	current_damage += base_damage * damage_change
	refresh_mods()

func refresh_mods():
	for mod in get_children():
		if mod is BaseMod:
			mod.refresh()

func show_weapon_image():
	weapon_image.show()
	
func hide_weapon_image():
	weapon_image.hide()

func get_texture():
	return weapon_image.texture
	
func get_base_damage():
	return base_damage

func get_current_damage():
	return current_damage

func add_mod(mod_to_add : BaseMod):
	adding_mod.emit(mod_to_add)
	add_child(mod_to_add)
