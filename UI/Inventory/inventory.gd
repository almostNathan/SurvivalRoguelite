extends PanelContainer
class_name Inventory

@onready var weapon_display_container = $WeaponDisplayContainer
@onready var weapon_grid_container = $WeaponDisplayContainer/WeaponGridContainer
@onready var weapon_slot_1 = $WeaponDisplayContainer/WeaponGridContainer/WeaponSlot
@onready var weapon_slot_2 = $WeaponDisplayContainer/WeaponGridContainer/WeaponSlot2
@onready var weapon_slot_3 = $WeaponDisplayContainer/WeaponGridContainer/WeaponSlot3
@onready var weapon_slot_4 = $WeaponDisplayContainer/WeaponGridContainer/WeaponSlot4
@onready var weapon_slot_5 = $WeaponDisplayContainer/WeaponGridContainer/WeaponSlot5
@onready var weapon_slot_6 = $WeaponDisplayContainer/WeaponGridContainer/WeaponSlot6

@onready var weapon_slot_array = [weapon_slot_1, weapon_slot_2, weapon_slot_3, weapon_slot_4, weapon_slot_5, weapon_slot_6]
var weapon_reference_array = []

func add_weapon(weapon_to_add):
	weapon_reference_array.append(weapon_to_add)
	update_inventory()

func reset_inventory():
	weapon_reference_array = []
	for weapon_slot in weapon_slot_array:
		weapon_slot.remove_weapon_in_slot()
	

func update_inventory():
	for i in range(len(weapon_reference_array)):
		weapon_slot_array[i].set_weapon_in_slot(weapon_reference_array[i])
