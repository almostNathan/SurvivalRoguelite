extends BulletMod
class_name SplashMod

var damage_value = 10
var splash_effect_scene = preload("res://GeneralMods/Effects/Splash/splash_effect.tscn")

func _init():
	tooltip_text = "Splash"
	icon = preload("res://Art/Drops/splash_mod.png")
	

func _ready():
	super()
	parent.on_hit.connect(_on_hit)
	refresh()

func _on_hit(body, bullet):
	body.add_to_mod_queue(self)

func apply_effect(body):
	var splash_effect = splash_effect_scene.instantiate()
	splash_effect.weapon = parent
	splash_effect.damage_value = damage_value
	parent.get_parent().add_sibling(splash_effect)
	splash_effect.global_position = body.global_position
	

func rank_up():
	current_rank += 1
	damage_value = (current_rank * damage_value) + current_rank

func damage_multiplier(mult_value):
	damage_value *= mult_value

func refresh():
	damage_value = parent.base_damage *.9

func damage_add(add_value):
	damage_value += add_value
