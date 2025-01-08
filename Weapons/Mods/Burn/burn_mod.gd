extends BaseMod
class_name BurnMod


var damage_value : float
var damage_coefficient = .6
var burn_duration : float
var burn_dps : float
var proc_chance = .1

var burn_debuff = preload("res://GeneralMods/Debuffs/Burn/burn_debuff.tscn")


func _init():
	tooltip_text = "Burn"
	icon = preload("res://Art/Drops/burn_mod.png")
	damage_number_color = Color(0, 0, 0, 1)

func equip(new_weapon):
	super(new_weapon)
	weapon.on_hit.connect(_on_hit)
	weapon.on_proc_hit.connect(_on_proc_hit)
	refresh()
	
func _on_hit(body, _bullet):
	if randf() < proc_chance and weapon != null:
		body.add_to_mod_queue(self)

func _on_proc_hit(body, _bullet, proc_multiplier):
	var modified_proc_chance = proc_chance * proc_multiplier
	if randf() < proc_chance:
		body.add_to_mod_queue(self)
	
func apply_effect(body):
	body.hit({'weapon' : weapon, 'damage' : snapped(damage_value, 1)})
	_apply_damage_numbers(body, snapped(damage_value, 1))
	var new_burn_debuff = burn_debuff.instantiate()
	body.add_debuff(new_burn_debuff)
	new_burn_debuff.set_dps(burn_dps)
	new_burn_debuff.set_duration(burn_duration)
	new_burn_debuff.set_weapon(weapon)	
	
func refresh():
	if weapon != null:
		damage_value = weapon.current_damage * damage_coefficient * current_rank
		burn_duration = weapon.base_attack_speed*2
		burn_dps = damage_value / burn_duration

func remove_mod():
	super()
	weapon.on_hit.disconnect(_on_hit)


