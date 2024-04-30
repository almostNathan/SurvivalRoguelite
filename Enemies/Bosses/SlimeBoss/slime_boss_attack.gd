extends Area2D
class_name SlimeBossAttack

@onready var animated_sprite = $AnimatedSprite2D
var base_damage = 10

func  _ready():
	animated_sprite.play('attack')


func _on_lifespan_timer_timeout():
	queue_free()



func _on_body_entered(body):
	if body is Player:
		body.take_damage(base_damage)
