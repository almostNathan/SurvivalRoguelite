extends Area2D
class_name PoisonCloudEffect

var poison_dps = 10
var poison_duration = 5
var radius_modifier = 1
var weapon : BaseWeapon
@onready var animation_sprite : AnimatedSprite2D = $Animation 

var poison_debuff = preload("res://GeneralMods/Debuffs/Poison/poison_debuff.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_sprite.play("explosion")



func _on_animation_animation_finished():
	queue_free()


func _on_body_entered(body):
	if body.has_method("hit") && body.is_in_group("enemy"):
		var new_poison_debuff = poison_debuff.instantiate()
		body.add_mod(new_poison_debuff)
		new_poison_debuff.set_dps(poison_dps)
		new_poison_debuff.set_duration(poison_duration)
		new_poison_debuff.set_weapon(weapon)


