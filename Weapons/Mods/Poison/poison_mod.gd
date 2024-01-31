extends BulletMod
class_name PoisonMod

@export var poison_dps = 5.0
@export var poison_duration = 5

var poison_debuff = preload("res://GeneralMods/Debuffs/Poison/poison_debuff.tscn")

func _init():
	tooltip_text = "Poison"	
	icon = preload("res://Art/Drops/poison_mod.png")

func _ready():
	super()
	parent.on_hit.connect(_on_hit)
	refresh()


func _on_hit(body, _bullet):
	body.add_to_mod_queue(self)

func apply_effect(body):
	var new_poison_debuff = poison_debuff.instantiate()
	new_poison_debuff.set_dps(poison_dps)
	new_poison_debuff.set_duration(poison_duration)
	new_poison_debuff.set_weapon(parent)
	body.add_debuff(new_poison_debuff)


func rank_up():
	current_rank += 1
	poison_dps = (poison_dps * current_rank) + (poison_dps / 3)
	
func refresh():
	poison_dps = parent.current_damage * .8
	



