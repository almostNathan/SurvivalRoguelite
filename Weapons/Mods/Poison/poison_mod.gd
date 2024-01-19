extends BulletMod
class_name PoisonMod

var poison_debuff = preload("res://GeneralMods/Debuffs/Poison/poison_debuff.tscn")
var poison_dps = 50.0

func _ready():
	super()
	parent.on_hit.connect(_on_hit)

func _on_hit(body):
	if parent is BaseBullet:
		body.add_to_mod_queue(self)

func apply_effect(body):
	var new_poison_debuff = poison_debuff.instantiate()
	new_poison_debuff.damage_per_second = poison_dps
	body.add_mod(new_poison_debuff)
