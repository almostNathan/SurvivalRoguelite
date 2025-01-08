extends PanelContainer
class_name PlayerMenu

@onready var weapons_container = $HBoxContainer/WeaponsMarginContainer/WeaponsContainer
@onready var mod_container = $HBoxContainer/ModsMarginContainer/VBoxContainer/ModContainer
@onready var inventory_player = $HBoxContainer/InventoryPlayer

var is_open = false
var weapon_inventory = []
var mod_inventory = []

var weapon_slot_scene = preload("res://UI/Inventory/InventoryWeaponSlot/inventory_weapon_slot.tscn")
var mod_slot_scene = preload("res://UI/Inventory/InventoryModSlot/inventory_mod_slot.tscn")

func load_player_menu():
	mod_inventory = Globals.player.mod_inventory
	weapon_inventory = Globals.player.weapon_inventory

	for weapon in weapon_inventory:
		var new_weapon_slot = weapon_slot_scene.instantiate()
		weapons_container.add_child(new_weapon_slot)
		new_weapon_slot.set_weapon_in_slot(weapon)

	for mod in mod_inventory:
		var new_mod_slot = mod_slot_scene.instantiate()
		mod_container.add_child(new_mod_slot)
		new_mod_slot.set_mod_in_slot(mod)
		new_mod_slot.custom_minimum_size = Vector2(50, 50)
	
	inventory_player.update()
	
	get_tree().paused = true
	visible = true
	is_open = true
	
func close_player_menu():
	#Apply currently attached mods and correct inventory
	Globals.player.mod_inventory = []
	for weapon in weapon_inventory:
		weapon.detach_all_mods()
		
	Globals.player.refresh_player_mods()
	
	for weapon_slot in weapons_container.get_children():
		weapon_slot.add_mods_to_weapon()
		weapons_container.remove_child(weapon_slot)
		weapon_slot.queue_free()
	for mod_slot in mod_container.get_children():
		Globals.player.mod_inventory.append(mod_slot.get_mod())
		mod_container.remove_child(mod_slot)
		mod_slot.queue_free()
	
	#inventory_player.equip_mods()
	
	Hud.update_weapons_display()
	get_tree().paused = false
	visible = false
	is_open = false
