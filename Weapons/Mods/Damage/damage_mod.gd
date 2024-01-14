extends BulletMod
class_name DamageMod

@export var damage_value : float = 10

func _ready():
	super()
	parent.on_hit.connect(_on_hit)

func _on_hit(body : BaseEnemy):
	body.add_to_mod_queue(self)

func apply_effect(enemy):
	enemy.take_damage(damage_value)


func damage_multiplier(mult_value):
	damage_value *= mult_value

func damage_add(add_value):
	damage_value += add_value
