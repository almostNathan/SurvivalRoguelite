extends MarginContainer
class_name InventoryWeaponSlot

signal mod_placed_in_weapon()

@onready var mod_grid = $ModGridContainer
@onready var weapon_icon = $Icon
@onready var mod_slot_label = $ModSlotLabel

var weapon_in_slot : BaseWeapon
var moddable = false
var open = true
var mod_slot_scene = preload("res://UI/Inventory/InventoryModSlot/inventory_mod_slot.tscn")

func _get_drag_data(_at_position):
	set_drag_preview(self.duplicate())
	if get_parent().name == "WeaponGridContainer":
		queue_free()
	return weapon_in_slot

func _drop_data(_at_position, data):
	#TODO Handle adding mods that upgrade.
	if data is BaseMod and weapon_in_slot.total_mod_slots > count_mods_on_weapon():
		var new_mod_slot = mod_slot_scene.instantiate()
		mod_grid.add_child(new_mod_slot)
		new_mod_slot.set_mod_in_slot(data)
		new_mod_slot.custom_minimum_size = Vector2(self.size.x/3, self.size.y/3)
		mod_slot_label.text = str(count_mods_on_weapon()) + ' / ' + str(weapon_in_slot.total_mod_slots)
		#weapon_in_slot.add_mod(data)
		#update_weapon_slot()
	elif data is BaseWeapon:
		set_weapon_in_slot(data)


func _can_drop_data(_at_position, data):
	if open and data is BaseWeapon:
		return true
	if moddable and data is BaseMod and weapon_in_slot.total_mod_slots > count_mods_on_weapon():
		return true


func set_weapon_in_slot(weapon):
	weapon_in_slot = weapon
	$Icon.texture = weapon.get_icon()
	update_weapon_slot()
	open = false
	moddable = true

func remove_weapon_in_slot():
	weapon_in_slot = null
	weapon_icon.texture = null
	open = true
	moddable = false

func _on_button_pressed():
	add_mods_to_weapon()

func add_mods_to_weapon():
	if mod_grid.get_children() == null:
		pass
	else:
		for mod_slot in mod_grid.get_children():
			weapon_in_slot.add_mod(mod_slot.get_mod())

func count_mods_on_weapon():
	var mod_array = mod_grid.get_children()
	return len(mod_array)

func update_weapon_slot():
	mod_slot_label.text = str(len(weapon_in_slot.mod_list)) + ' / ' + str(weapon_in_slot.total_mod_slots)
	var mod_slot_size = $Icon.size.x/3
	clear_mod_grid_container()
	for mod in weapon_in_slot.get_mod_list():
		var new_mod_slot = mod_slot_scene.instantiate()
		mod_grid.add_child(new_mod_slot)
		new_mod_slot.set_mod_in_slot(mod)
		new_mod_slot.custom_minimum_size = Vector2(mod_slot_size, mod_slot_size)

func clear_mod_grid_container():
	for mod in mod_grid.get_children():
		mod_grid.remove_child(mod)
		mod.queue_free()

func remove_mod_from_inventory(mod):
	var mod_inventory = Globals.player.mod_inventory
	mod_inventory.remove_at(mod_inventory.find(mod))
