extends BulletMod
class_name DamageMod

var damage_value : float = 10



func _init():
	tooltip_text = "Damage"
	icon = preload("res://Art/Drops/damage_mod.png")

func _ready():
	super()
	parent.on_hit.connect(_on_hit)
	refresh()

func _on_hit(body, _bullet):
	body.add_to_mod_queue(self)

func apply_effect(body):
	damage_value = parent.current_damage
	mod_hitting.emit(self)
	body.hit(parent, damage_value)
	


func rank_up():
	current_rank += 1
	damage_value = (current_rank * damage_value) + current_rank

func damage_multiplier(mult_value):
	damage_value *= mult_value

func refresh():
	damage_value = parent.current_damage

func damage_add(add_value):
	damage_value += add_value
