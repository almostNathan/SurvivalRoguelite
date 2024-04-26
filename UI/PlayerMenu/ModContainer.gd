extends GridContainer
class_name ModContainer

var mod_slot_scene = preload("res://UI/Inventory/InventoryModSlot/inventory_mod_slot.tscn")

func _can_drop_data(_at_position, data):
	if data is BaseMod:
		return true


func _drop_data(_at_position, data):
	#TODO Handle adding mods that upgrade.
	if data is BaseMod:
		var new_mod_slot = mod_slot_scene.instantiate()
		add_child(new_mod_slot)
		new_mod_slot.set_mod_in_slot(data)
		new_mod_slot.custom_minimum_size = Vector2(50, 50)
