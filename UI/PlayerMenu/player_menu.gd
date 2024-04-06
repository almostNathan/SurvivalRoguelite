extends PanelContainer
class_name PlayerMenu

@onready var weapons_container = $HBoxContainer/WeaponsMarginContainer/WeaponsContainer
@onready var mod_container = $HBoxContainer/ModsMarginContainer/ModContainer


var is_open = false
var weapon_inventory = []
var mod_inventory = []

var weapon_slot_scene = preload("res://UI/Inventory/InventoryWeaponSlot/inventory_weapon_slot.tscn")
var mod_slot_scene = preload("res://UI/Inventory/InventoryModSlot/inventory_mod_slot.tscn")

func load_player_menu():
	mod_inventory = Globals.player.mod_inventory
	weapon_inventory = Globals.player.weapon_inventory
	print(weapon_inventory)

	for weapon in weapon_inventory:
		var new_weapon_slot = weapon_slot_scene.instantiate()
		weapons_container.add_child(new_weapon_slot)
		new_weapon_slot.set_weapon_in_slot(weapon)


	for mod in mod_inventory:
		var new_mod_slot = mod_slot_scene.instantiate()
		mod_container.add_child(new_mod_slot)
		new_mod_slot.set_mod_in_slot(mod)
		new_mod_slot.custom_minimum_size = Vector2(50, 50)
	get_tree().paused = true
	visible = true
	is_open = true
	
func close_player_menu():
	for weapon in weapons_container.get_children():
		weapons_container.remove_child(weapon)
		weapon.queue_free()
	for mod in mod_container.get_children():
		mod_container.remove_child(mod)
		mod.queue_free()
	get_tree().paused = false
	visible = false
	is_open = false
