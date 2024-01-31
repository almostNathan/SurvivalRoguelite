extends PanelContainer

@onready var weapon_grid_container : GridContainer = $VSplitContainer/MarginContainer/WeaponGridContainer
@onready var mod_grid_container : GridContainer = $VSplitContainer/MarginContainer2/ModGridContainer
@onready var main_weapon_slot = $VSplitContainer/MarginContainer/WeaponGridContainer/MainWeaponSlot
@onready var offhand_weapon_slot = $VSplitContainer/MarginContainer/WeaponGridContainer/OffhandWeaponSlot


var mod_slot_scene = preload("res://ConfigMenu/configure_mod_slot.tscn")

var player :CharacterBody2D
var player_main_weapon
var player_offhand_weapon
var mod_list = AllModList.mod_scene_list


func _ready():
	for mod_scene in mod_list:
		var new_mod_slot = mod_slot_scene.instantiate()
		var mod_instance = mod_scene.instantiate()
		new_mod_slot.set_mod_in_slot(mod_instance)
		new_mod_slot.custom_minimum_size = Vector2(50,50)
		mod_grid_container.add_child(new_mod_slot)

func _on_player_ready():
	player = get_parent()
	player_main_weapon = player.main_weapon
	player_offhand_weapon = player.offhand_weapon
	main_weapon_slot.set_weapon_in_slot(player_main_weapon)
	offhand_weapon_slot.set_weapon_in_slot(player_offhand_weapon)

func _on_button_pressed():
	visible = false
	get_tree().paused = false

