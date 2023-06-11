extends Area2D

@export var damage = 10
@export var radius_modifier = 1
var attack : Attack

# Called when the node enters the scene tree for the first time.
func _ready():
	attack = Attack.new()
	attack.attack_damage = damage
	attack.knockback_force = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_animation_animation_finished():
	queue_free()


func _on_body_entered(body):
	if body.has_method("hit") && body.is_in_group("enemy"):
		body.hit(attack)


