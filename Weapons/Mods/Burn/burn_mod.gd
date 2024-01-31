extends BaseMod
class_name BurnMod


var damage_value : float
var burn_duration : float
var burn_dps : float

var burn_debuff = preload("res://GeneralMods/Debuffs/Burn/burn_debuff.tscn")


func _init():
	tooltip_text = "Burn"
	icon = preload("res://Art/Drops/burn_mod.png")

func _ready():
	super()
	parent.on_hit.connect(_on_hit)
	refresh()
	
func _on_hit(body, _weapon):
	body.add_to_mod_queue(self)
	
func apply_effect(body):
	body.hit(parent, damage_value)
	var new_burn_debuff = burn_debuff.instantiate()
	body.add_mod(new_burn_debuff)
	new_burn_debuff.set_dps(burn_dps)
	new_burn_debuff.set_duration(burn_duration)
	new_burn_debuff.set_weapon(parent)
	
func refresh():
	damage_value = parent.current_damage * .6
	burn_duration = parent.base_attack_speed*2
	burn_dps = damage_value / burn_duration

