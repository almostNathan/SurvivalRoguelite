extends Node2D
class_name BaseMod

signal mod_hitting(mod)

var damage_numbers_scene = preload("res://UI/DamageNumbers/damage_numbers.tscn")

var icon : CompressedTexture2D

var mod_name = "Base"
var need_refresh = false
var weapon
var current_rank = 1
var damage_number_color : Color = Color(0, 0, 0, 1)
var rarity = "common"
var tags = []
var is_equipped = false
var tooltip_description : String = ""
var signal_array = []

func _init():
	set_base_data()
	var mod_data = AllModList.mod_data.filter(func(data_dict): return data_dict["name"] == mod_name)
	rarity = mod_data[0]["rarity"]
	tags = mod_data[0]["tags"]

func remove_mod():
	is_equipped = false

func set_base_data():
	pass

func unequip():
	if weapon:
		weapon.remove_mod(self)


func equip(new_weapon):
	weapon = new_weapon
	is_equipped = true
	refresh()

func refresh():
	pass

#Must disconnect any signals
#Create signal array this function could handle any mod

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

func get_tooltip_description():
	return tooltip_description

func _get_weapon_stats():
	var weapon_stats = {
		'weapon' : weapon,
		'damage' : 0
	}

func get_object_name():
	return mod_name

func _apply_damage_numbers(body, damage_value):
	var new_damage_numbers = damage_numbers_scene.instantiate()
	body.add_sibling(new_damage_numbers)
	var style_settings = {
		'color' : damage_number_color
	}
	new_damage_numbers.set_style(style_settings)

	new_damage_numbers.set_values_and_animate(snapped(damage_value, 1), body.position, 100, 100)
