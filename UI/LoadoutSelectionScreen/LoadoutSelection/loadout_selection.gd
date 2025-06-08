extends Control
class_name LoadoutSelection

signal loadout_button_pressed(loadout_data : Dictionary)

@onready var loadout_image = $MarginContainer/VBoxContainer/LoadoutImage
@onready var loadout_button = $MarginContainer/VBoxContainer/LoadoutButton
@onready var mod_grid = $MarginContainer/VBoxContainer/LoadoutImage/ModGrid


var loadout_weapon : BaseWeapon
var loadout_weapon_scene : PackedScene
var loadout_mod_scene_list : Array = []
var loadout_option_data


func set_loadout_selection(loadout_options : Dictionary):
	loadout_option_data = loadout_options
	loadout_weapon = loadout_options["weapon"]
	loadout_weapon_scene = loadout_options["weapon_scene"]
	for mod_scene in loadout_options["mod_list"]:
		loadout_mod_scene_list.append(mod_scene)
		var new_mod = mod_scene.instantiate()
		var new_mod_image = TextureRect.new()
		new_mod_image.custom_minimum_size = Vector2(loadout_image.size.x/3,loadout_image.size.y/3)
		new_mod_image.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		new_mod_image.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		new_mod_image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		mod_grid.add_child(new_mod_image)
		new_mod_image.texture = new_mod.icon
	
	loadout_image.texture = loadout_weapon.icon
	



func _on_loadout_button_pressed():
	var loadout_data = {
		"loadout_weapon_scene": loadout_weapon_scene,
		"loadout_mod_scene_list": loadout_mod_scene_list,
		'loadout_option_data' : loadout_option_data
	}
	loadout_button_pressed.emit(loadout_data)
