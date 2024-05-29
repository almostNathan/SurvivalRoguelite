extends Area2D
class_name SplashEffect

var damage_value = 10
var radius_modifier = 1
var weapon : BaseWeapon
var origin_enemy
@onready var animation_sprite : AnimatedSprite2D = $Animation 

var damage_numbers_scene = preload("res://UI/DamageNumbers/damage_numbers.tscn")

func _ready():
	animation_sprite.play("explosion")

func _on_animation_animation_finished():
	queue_free()

func _on_body_entered(body):
	if body.has_method("hit") && body.is_in_group("enemy") && body != origin_enemy:
		body.hit({'weapon' : weapon, 'damage' : snapped(damage_value, 1)})
		_apply_damage_numbers(body)

func _apply_damage_numbers(body):
	var new_damage_numbers = damage_numbers_scene.instantiate()
	body.add_sibling(new_damage_numbers)
	var style_settings = {
		'color' : Color(1,1,1,1)
	}
	new_damage_numbers.set_style(style_settings)
	new_damage_numbers.set_values_and_animate(snapped(damage_value, 1), body.position, 100, 100)

