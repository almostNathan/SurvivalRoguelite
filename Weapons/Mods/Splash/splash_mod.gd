extends BaseMod
class_name SplashMod

var damage_value = 10
var damage_coefficient = .5
var splash_effect_scene = preload("res://GeneralMods/Effects/Splash/splash_effect.tscn")

func _init():
	tooltip_text = "Splash"
	icon = preload("res://Art/Drops/splash_mod.png")
	

func equip(new_weapon):
	super(new_weapon)
	weapon.on_hit.connect(_on_hit)
	refresh()

func _on_hit(body, _bullet):
	body.add_to_mod_queue(self)

func apply_effect(body):
	var splash_effect = splash_effect_scene.instantiate()
	splash_effect.origin_enemy = body
	splash_effect.weapon = weapon
	splash_effect.damage_value = damage_value
	weapon.get_parent().add_sibling(splash_effect)
	splash_effect.global_position = body.global_position
	

func damage_multiplier(mult_value):
	damage_value *= mult_value

func refresh():
	if weapon != null:
		damage_value = weapon.current_damage * damage_coefficient * current_rank

func damage_add(add_value):
	damage_value += add_value

func remove_mod():
	super()
	weapon.on_hit.disconnect(_on_hit)

