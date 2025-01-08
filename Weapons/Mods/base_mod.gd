extends Node2D
class_name BaseMod

signal mod_hitting(mod)

var damage_numbers_scene = preload("res://UI/DamageNumbers/damage_numbers.tscn")

var tooltip_text : String
var icon : CompressedTexture2D

var need_refresh = false
var weapon
var current_rank = 1
var damage_number_color : Color = Color(0, 0, 0, 1)

func equip(new_weapon):
	self.weapon = new_weapon
	refresh()

func refresh():
	pass

#Must disconnect any signals
#Create signal array this function could handle any mod
func remove_mod():
	pass

func can_upgrade(new_mod):
	if new_mod.name == self.name and new_mod.current_rank == self.current_rank and new_mod != self:
		return true
	else:
		return false

func upgrade_mod(new_mod):
	if can_upgrade(new_mod):
		current_rank += 1
		need_refresh = true
		refresh()

func get_tooltip_text():
	return tooltip_text

func _get_weapon_stats():
	var weapon_stats = {
		'weapon' : weapon,
		'damage' : 0
	}


func _apply_damage_numbers(body, damage_value):
	var new_damage_numbers = damage_numbers_scene.instantiate()
	body.add_sibling(new_damage_numbers)
	var style_settings = {
		'color' : damage_number_color
	}
	new_damage_numbers.set_style(style_settings)

	new_damage_numbers.set_values_and_animate(snapped(damage_value, 1), body.position, 100, 100)
