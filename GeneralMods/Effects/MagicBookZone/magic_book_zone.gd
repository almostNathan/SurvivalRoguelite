extends Area2D
class_name MagicBookZone

var radius_modifier = 1
var weapon : BaseWeapon
@onready var animation_sprite : AnimatedSprite2D = $Animation 


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_sprite.play("explosion")

func _on_animation_animation_finished():
	queue_free()

func _on_body_entered(body):
	if body.has_method("hit") && body.is_in_group("enemy"):
		weapon.emit_signal("on_hit", body, self)

