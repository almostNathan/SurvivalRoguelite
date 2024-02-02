extends Area2D
class_name SplashEffect

var damage_value = 10
var radius_modifier = 1
var weapon : BaseWeapon
@onready var animation_sprite : AnimatedSprite2D = $Animation 


func _ready():
	animation_sprite.play("explosion")

func _on_animation_animation_finished():
	queue_free()

func _on_body_entered(body):
	if body.has_method("hit") && body.is_in_group("enemy"):
		body.hit(weapon, damage_value)


