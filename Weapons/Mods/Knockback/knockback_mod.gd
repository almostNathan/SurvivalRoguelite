extends BaseMod
class_name KnockbackMod

var knockback_debuff = preload("res://GeneralMods/Debuffs/Knockback/knockback_debuff.tscn")

func _init():
	tooltip_text = "Knockback"
	icon = preload("res://Art/Drops/knockback_mod.png")

func _ready():
	super()
	parent.on_hit.connect(_on_hit)
	refresh()

func _on_hit(body, bullet):
	body.add_to_mod_queue(self)

func apply_effect(body):
	body.add_mod(knockback_debuff.instantiate())
