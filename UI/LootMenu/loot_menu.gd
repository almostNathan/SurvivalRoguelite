extends PanelContainer
class_name LootMenu

@onready var weapon_grid_container = $HSplitContainer/MarginContainer/WeaponGridContainer
@onready var mod_grid_container = $HSplitContainer/MarginContainer2/ModGridContainer
@onready var player

var weapon_slot_scene = preload("res://ConfigMenu/configure_weapon_slot.tscn")
var mod_slot_scene = preload("res://ConfigMenu/configure_mod_slot.tscn")
var main_weapon_slot
var offhand_weapon_slot


func load_loot_screen(loot_scene_list):
	player = Globals.player
	for loot_scene in loot_scene_list:
		var new_loot = loot_scene.instantiate()
		var mod_slot = mod_slot_scene.instantiate()
		mod_slot.custom_minimum_size = Vector2(50, 50)
		mod_grid_container.add_child(mod_slot)
		mod_slot.set_mod_in_slot(new_loot)
	
	main_weapon_slot = weapon_slot_scene.instantiate()
	offhand_weapon_slot = weapon_slot_scene.instantiate()
	
	weapon_grid_container.add_child(main_weapon_slot)
	weapon_grid_container.add_child(offhand_weapon_slot)
	main_weapon_slot.set_weapon_in_slot(player.main_weapon)
	offhand_weapon_slot.set_weapon_in_slot(player.offhand_weapon)
	main_weapon_slot.mod_placed_in_weapon.connect(_loot_selected)
	offhand_weapon_slot.mod_placed_in_weapon.connect(_loot_selected)
	
	get_tree().paused = true
	visible = true


func _loot_selected():
	#TODO: empty out weapon/mod grid containers so next loot screen can rebuild
	main_weapon_slot.add_mods_to_weapon()
	offhand_weapon_slot.add_mods_to_weapon()
	main_weapon_slot.queue_free()
	offhand_weapon_slot.queue_free()
	for mod_slot in mod_grid_container.get_children():
		mod_slot.queue_free()
	
	get_tree().paused = false
	visible = false
