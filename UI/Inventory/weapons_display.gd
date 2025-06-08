extends PanelContainer
class_name WeaponsDisplay


@onready var weapons_display_container = $VBoxContainer

var weapons_display_slot = preload("res://UI/Inventory/weapons_display_slot.tscn")

func update():
	var weapon_list = Globals.player.weapon_inventory
	clear()
	for weapon in weapon_list:
		var new_weapons_display_slot = weapons_display_slot.instantiate()
		weapons_display_container.add_child(new_weapons_display_slot)
		new_weapons_display_slot.set_weapon_in_slot(weapon)

func clear():
	for weapons_display_slot in weapons_display_container.get_children():
		weapons_display_container.remove_child(weapons_display_slot)
		weapons_display_slot.queue_free()
