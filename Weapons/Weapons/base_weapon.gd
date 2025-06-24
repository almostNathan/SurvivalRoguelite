extends Node2D
class_name BaseWeapon

signal shooting_weapon()
signal off_cooldown(body)
signal on_hit(body, bullet)
signal on_proc_hit(body, bullet, proc_multiplier)
signal on_kill(body)
signal adding_mod(mod)

@export var bullet_scene : PackedScene
var weapon_name = 'Weapon Name'
var speed = 700.0
var base_damage = 20
var current_damage = base_damage
var mod_list : Array[BaseMod] = []

@onready var weapon_image = $Image
var icon
@onready var weapon_timer : Timer = $WeaponTimer

var total_mod_slots = 3
var current_mod_count = 0
var player : CharacterBody2D

var base_attack_speed = 1
var current_attack_speed = base_attack_speed
var damage_modifier_add = 0
var damage_modifier_mult = 1
var damage_modifier_level = 1
var attack_speed_modifier_add = 0
var attack_speed_modifier_mult = 1
var duration_modifier_mult = 1
var area_modifier_mult = 1
var projectile_speed_modifier_mult = 1
var projectile_count = 1
var shooting_angle = PI
var left_shooting_angle
var angle_between_bullets
var bounce_value = 0
var pierce_value = 0
var is_melee = false
var is_equipped = false

var damage_mod_scene = preload("res://Weapons/Mods/Damage/damage_mod.tscn")
var damage_mod

var tooltip_text = 'No Tooltip'

func _ready():
	if get_parent() is Player:
		player = get_parent()
	weapon_timer.wait_time = base_attack_speed
	is_equipped = true
	damage_mod = damage_mod_scene.instantiate()
	damage_mod.equip(self)

func get_object_name():
	return weapon_name

func modify_bullet(new_bullet):
	new_bullet.set_duration_modifier(duration_modifier_mult)

func get_image_texture():
	return weapon_image.texture

func get_cooldown():
	return weapon_timer.time_left

func _on_weapon_timer_timeout():
	var aiming_direction :float= Vector2.RIGHT.angle_to(player.aiming_direction)

	left_shooting_angle = aiming_direction + (shooting_angle/2)
	angle_between_bullets = shooting_angle / (projectile_count + 1)

	for i in range(projectile_count):
		var new_bullet = create_new_bullet()
		new_bullet.set_weapon(self)
		player.add_sibling(new_bullet)
		new_bullet.set_player(player)
		shooting_weapon.emit(new_bullet)
		modify_bullet(new_bullet)
		new_bullet.global_position = player.position
		set_bullet_aiming(new_bullet, i, aiming_direction)

func hit(body, bullet):
	on_hit.emit(body, bullet)

func proc_hit(body, bullet, proc_multiplier):
	on_proc_hit.emit(body, bullet, proc_multiplier)


func set_bullet_aiming(new_bullet, bullet_number, _aiming_direction):
	new_bullet.set_movement_direction(Vector2.RIGHT.rotated(left_shooting_angle - (angle_between_bullets * (bullet_number+1))))

func modify_attack_speed_add(attack_speed_change):
	attack_speed_modifier_add += attack_speed_change
	calc_attack_speed()

func modify_attack_speed_mult(attack_speed_change):
	attack_speed_modifier_mult += attack_speed_change
	calc_attack_speed()

func calc_attack_speed():
	current_attack_speed = (base_attack_speed + attack_speed_modifier_add) / attack_speed_modifier_mult
	if weapon_timer:
		weapon_timer.wait_time = current_attack_speed

func modify_damage_add(modifier_change):
	damage_modifier_add += modifier_change
	calc_damage()
	refresh_mods()

func modify_damage_mult(modifier_change):
	damage_modifier_mult += modifier_change
	calc_damage()
	refresh_mods()

#Damage scaling from Leveling
func modify_damage_level(new_modifier):
	damage_modifier_level = new_modifier
	calc_damage()
	refresh_mods()

func calc_damage():
	current_damage = (base_damage + damage_modifier_add) * damage_modifier_mult * damage_modifier_level

func modify_area_mult(modifier_change):
	area_modifier_mult += modifier_change

func modify_projectile_speed_mult(modifier_change):
	projectile_speed_modifier_mult += modifier_change

func modify_duration_mult(modifier_change):
	duration_modifier_mult += modifier_change

func refresh_mods():
	if damage_mod:
		damage_mod.refresh()
	for mod in mod_list:
		if mod is BaseMod:
			mod.refresh()

func show_weapon_image():
	weapon_image.show()
	
func hide_weapon_image():
	weapon_image.hide()

func get_icon():
	return icon
	
func get_base_damage():
	return base_damage

func get_current_damage():
	return current_damage

func add_mod(mod_to_add : BaseMod):
	mod_to_add.equip(self)
	mod_list.append(mod_to_add)
	adding_mod.emit(mod_to_add)

func remove_mod(mod_to_remove : BaseMod):
	print("baseweapon, removing mod ", mod_to_remove)
	mod_to_remove.remove_mod()
	mod_list.remove_at(mod_list.find(self))
	
func get_mod_list():
	return mod_list

func detach_all_mods():
	for mod in mod_list:
		mod.remove_mod()
	mod_list = []
	
func create_new_bullet():
	var new_bullet = bullet_scene.instantiate()
	new_bullet.set_area_modifier(area_modifier_mult)
	new_bullet.set_projectile_speed_modifier(projectile_speed_modifier_mult)
	return new_bullet

func apply_player_mods_to_weapon(weapon : BaseWeapon):
	player.apply_player_mods_to_weapon(weapon)

func toggle(on : bool):
	if on:
		if weapon_timer.is_stopped():
			weapon_timer.start()
	elif !on:
		if !weapon_timer.is_stopped():
			weapon_timer.stop()
