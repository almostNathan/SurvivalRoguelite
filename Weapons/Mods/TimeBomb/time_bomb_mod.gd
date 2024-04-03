extends BaseMod
class_name TimeBombMod

var time_bomb_effect = preload("res://GeneralMods/Effects/TimeBomb/time_bomb_effect.tscn")
var damage_value : float

func _init():
	tooltip_text = "Time Bomb"
	icon = preload("res://Art/Drops/time_bomb_mod.png")

func _ready():
	super()
	parent.on_hit.connect(_on_hit)
	refresh()

func _on_hit(body, _bullet):
	body.add_to_mod_queue(self)

func apply_effect(body):
	var time_bomb_effect_instance = time_bomb_effect.instantiate()
	body.add_mod(time_bomb_effect_instance)
	time_bomb_effect_instance.weapon = parent
	time_bomb_effect_instance.damage = damage_value
	
func refresh():
	damage_value = parent.current_damage * 2
	
