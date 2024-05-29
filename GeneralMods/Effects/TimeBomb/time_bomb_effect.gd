extends Node2D

var parent : CharacterBody2D
var weapon : BaseWeapon
var damage_value : float
@onready var animation_sprite : AnimatedSprite2D = $Animation 

var damage_numbers_scene = preload("res://UI/DamageNumbers/damage_numbers.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()



func _on_timer_timeout():
	animation_sprite.reparent(parent.get_parent())
	animation_sprite.visible = true
	animation_sprite.play("explosion")
	var weapon_stats = _get_weapon_stats()
	_apply_damage_numbers(parent)
	parent.hit(weapon_stats)
	queue_free()

func _get_weapon_stats():
	var weapon_stats = {
		'weapon' : weapon,
		'damage' : snapped(damage_value, 1)
	}
	return weapon_stats

func _apply_damage_numbers(body):
	var new_damage_numbers = damage_numbers_scene.instantiate()
	body.add_sibling(new_damage_numbers)
	var style_settings = {
		'color' : Color(0,1,0,1)
	}
	new_damage_numbers.set_style(style_settings)
	new_damage_numbers.set_values_and_animate(snapped(damage_value, 1), body.position, 100, 100)
