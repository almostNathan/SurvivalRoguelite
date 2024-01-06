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

func get_image_texture():
	return weapon_image.texture

func add_mod(mod_to_add):
	add_child(mod_to_add)

func get_cooldown():
	return weapon_cooldown.time_left

func _on_weapon_timer_timeout():
	var new_bullet = bullet_scene.instantiate()
	get_parent().add_sibling(new_bullet)
	shooting_weapon.emit(new_bullet)
	new_bullet.global_position = get_parent().position
	new_bullet.rotation = get_parent().aiming_direction
