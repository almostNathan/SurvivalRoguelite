extends PanelContainer

@onready var weapon_grid_container : GridContainer = $HSplitContainer/VSplitContainer/MarginContainer/WeaponGridContainer
@onready var mod_grid_container : GridContainer = $HSplitContainer/VSplitContainer/MarginContainer2/ModGridContainer
@onready var main_weapon_slot = $HSplitContainer/VSplitContainer/MarginContainer/WeaponGridContainer/MainWeaponSlot
@onready var offhand_weapon_slot = $HSplitContainer/VSplitContainer/MarginContainer/WeaponGridContainer/OffhandWeaponSlot
@onready var available_weapons_container = $HSplitContainer/AvailableWeaponsGridContainer

var mod_slot_scene = preload("res://ConfigMenu/configure_mod_slot.tscn")
var weapon_slot_scene = preload("res://ConfigMenu/configure_weapon_slot.tscn")

var player : Player
var mod_list = AllModList.mod_data.filter(func(data_dict): return data_dict["name"] != "Base").map(func(data_dict): return data_dict["scene_path"])
var weapon_list = AllWeaponList.weapon_scene_list


func _ready():
	for mod_scene_path in mod_list:
		var new_mod_slot = mod_slot_scene.instantiate()
		var mod_instance = load(mod_scene_path).instantiate()
		new_mod_slot.set_mod_in_slot(mod_instance)
		new_mod_slot.custom_minimum_size = Vector2(50,50)
		mod_grid_container.add_child(new_mod_slot)
	
	for weapon_scene in weapon_list:
		var new_weapon_slot = weapon_slot_scene.instantiate()
		var weapon_instance = weapon_scene.instantiate()
		available_weapons_container.add_child(new_weapon_slot)
		new_weapon_slot.set_weapon_in_slot(weapon_instance)
		new_weapon_slot.custom_minimum_size = Vector2(100,100)
		new_weapon_slot.moddable = false

func open():
	clear_weapons_config()
	visible = true
	get_tree().paused = true

func clear_weapons_config():
	for weapon_slot in weapon_grid_container.get_weapon_slots():
		weapon_slot.remove_weapon_in_slot()


func _on_button_pressed():
	player = Globals.player
	for weapon_slot in weapon_grid_container.get_weapon_slots():
		if weapon_slot.weapon_in_slot != null:
			player.add_to_weapon_inventory(weapon_slot.weapon_in_slot)
			AllWeaponList.remove_weapon_from_pool(weapon_slot.weapon_in_slot)
			
		
	player.equip_weapons()
	Hud.update_weapons_display()
	
	#var damage_player_mod = preload("res://Player/Mods/DamagePlayerMod/damage_player_mod.tscn").instantiate()
	#damage_player_mod.equip(player)

	visible = false
	get_tree().paused = false

