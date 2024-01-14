extends Node2D
class_name BaseWeapon

signal shooting_weapon()
signal off_cooldown(body)

@export var bullet_scene : PackedScene
@export var speed = 700.0
@export var shooting_angle = PI

@onready var weapon_image = $Image
@onready var weapon_cooldown : Timer = $WeaponTimer

var available_mod_slots = 0
var current_mod_count = 0
var player : CharacterBody2D
var bullet_proto : BaseBullet

var base_attack_speed = 1
var attack_speed_modifier_add = 0
var attack_speed_modifier_mult = 1

func _ready():
	weapon_cooldown.wait_time = base_attack_speed
	bullet_proto = bullet_scene.instantiate()

func get_image_texture():
	return weapon_image.texture

func add_mod(mod_to_add):
	if mod_to_add is BulletMod:
		bullet_proto.add_child(mod_to_add)
	else:
		add_child(mod_to_add)

func get_cooldown():
	return weapon_cooldown.time_left

func _on_weapon_timer_timeout():
	var new_bullet = bullet_proto.duplicate()
	get_parent().add_sibling(new_bullet)
	shooting_weapon.emit(new_bullet)
	new_bullet.global_position = get_parent().position
	new_bullet.set_movement_direction(get_parent().aiming_direction)

func modify_attack_speed_add(attack_speed_change):
	attack_speed_modifier_add += attack_speed_change
	set_attack_speed()

func modify_attack_speed_mult(attack_speed_change):
	attack_speed_modifier_mult += attack_speed_change
	set_attack_speed()

func set_attack_speed():
	weapon_cooldown.wait_time = (base_attack_speed + attack_speed_modifier_add) * attack_speed_modifier_mult

func hide_weapon_image():
	weapon_image.hide()

func show_weapon_image():
	weapon_image.show()
