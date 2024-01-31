extends BulletMod
class_name ExplodeOnDeathMod

var damage_value : float = 10
var damage_coefficient = .5
var splash_effect_scene = preload("res://GeneralMods/Effects/Splash/splash_effect.tscn")

func _init():
	tooltip_text = "Explode On Death"
	icon = preload("res://Art/Drops/damage_mod.png")

func _ready():
	super()
	parent.on_kill.connect(_on_kill)
	refresh()

func _on_kill(body):
	var splash_effect = splash_effect_scene.instantiate()
	splash_effect.weapon = parent
	splash_effect.damage_value = damage_value
	body.add_sibling(splash_effect)
	splash_effect.global_position = body.global_position

func rank_up():
	current_rank += 1
	damage_value = (current_rank * damage_value) + current_rank

func damage_multiplier(mult_value):
	damage_value *= mult_value

func refresh():
	damage_value = parent.current_damage * damage_coefficient

func damage_add(add_value):
	damage_value += add_value
