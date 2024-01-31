extends Node2D

var parent : CharacterBody2D
var weapon : BaseWeapon
var damage : float
@onready var animation_sprite : AnimatedSprite2D = $Animation 

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()



func _on_timer_timeout():
	animation_sprite.reparent(parent.get_parent())
	animation_sprite.visible = true
	animation_sprite.play("explosion")
	parent.hit(weapon, damage)
	queue_free()

