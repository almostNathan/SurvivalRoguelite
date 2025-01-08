extends BaseMod
class_name PoisonMod

var poison_dps = 5.0
var poison_duration = 5
var poison_dps_coefficient = .8
var proc_chance = .1

var poison_debuff = preload("res://GeneralMods/Debuffs/Poison/poison_debuff.tscn")

func _init():
	tooltip_text = "Poison"	
	icon = preload("res://Art/Drops/poison_mod.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.on_hit.connect(_on_hit)
	weapon.on_proc_hit.connect(_on_proc_hit)
	refresh()


func _on_hit(body, _bullet):
	if randf() < proc_chance and weapon != null:
		body.add_to_mod_queue(self)

func _on_proc_hit(body, _bullet, proc_multiplier):
	if randf() < (proc_chance * proc_multiplier):
		body.add_to_mod_queue(self)

func apply_effect(body):
	var new_poison_debuff = poison_debuff.instantiate()
	body.add_debuff(new_poison_debuff)
	new_poison_debuff.poison_dps = poison_dps
	new_poison_debuff.poison_duration = poison_duration
	new_poison_debuff.weapon = weapon

func refresh():
	if weapon != null:
		poison_dps = weapon.current_damage * poison_dps_coefficient * current_rank
	

func remove_mod():
	super()
	weapon.on_hit.disconnect(_on_hit)

