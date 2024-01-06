extends PanelContainer

var main_weapon_slot 
@onready var weapon_display_container = $WeaponDisplayContainer
@onready var weapon_grid_container = $WeaponDisplayContainer/WeaponGridContainer
@onready var weapon_slot_1 = $WeaponDisplayContainer/WeaponGridContainer/WeaponSlot

func _ready():
	main_weapon_slot = get_parent().find_child("WeaponSlot")
	weapon_slot_1 = main_weapon_slot
	get_node("/root/Main").menu_button_pressed.connect(open_inventory)
	

func open_inventory():
	get_tree().paused = true
	weapon_slot_1 = get_parent().find_child("WeaponSlot").duplicate()
	show()




func _on_menu_button_pressed():
	hide()
	get_tree().paused = false
