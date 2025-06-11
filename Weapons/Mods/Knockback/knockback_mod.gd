extends BaseMod
class_name KnockbackMod

var knockback_debuff = preload("res://GeneralMods/Debuffs/Knockback/knockback_debuff.tscn")

func set_base_data():
	tooltip_text = "Knockback"
	mod_name = "Knockback"
	#TODO need icon
	
func equip(weapon):
	super(weapon)
	weapon.on_hit.connect(_on_hit)
	refresh()

func _on_hit(body, bullet):
	body.add_to_mod_queue(self)

func apply_effect(body):
	body.add_mod(knockback_debuff.instantiate())

func remove_mod():
	super()
	weapon.on_hit.disconnect(_on_hit)
