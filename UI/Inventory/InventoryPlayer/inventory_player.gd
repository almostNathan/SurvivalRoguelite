extends MarginContainer
class_name InventoryPlayer

@onready var player_mod_container : GridContainer = $PlayerModContainer
var mod_slot_scene = preload("res://UI/Inventory/InventoryModSlot/inventory_mod_slot.tscn")


func _can_drop_data(_at_position, data):

	if data is BasePlayerMod :
		return true

func _drop_data(_at_position, data):
	#TODO Handle adding mods that upgrade.
	if data is BasePlayerMod:
		var new_mod_slot = mod_slot_scene.instantiate()
		player_mod_container.add_child(new_mod_slot)
		new_mod_slot.set_mod_in_slot(data)
		new_mod_slot.custom_minimum_size = Vector2(self.size.x/3, self.size.y/3)
		#weapon_in_slot.add_mod(data)
		#update_weapon_slot()

func equip_mods():
	var player = Globals.player
	for mod_slot in player_mod_container.get_children():
		mod_slot.mod_in_slot.equip(player)

func update():
	for mod_slot in player_mod_container.get_children():
		player_mod_container.remove_child(mod_slot)
		mod_slot.queue_free()
	
	for mod in Globals.player.player_mod_list:
		var new_mod_slot = mod_slot_scene.instantiate()
		player_mod_container.add_child(new_mod_slot)
		new_mod_slot.set_mod_in_slot(mod)
		new_mod_slot.custom_minimum_size = Vector2(self.size.x/3, self.size.y/3)
