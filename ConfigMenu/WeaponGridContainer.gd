extends GridContainer

func get_weapon_slots():
	var return_array : Array = []
	for item in get_children():
		if item is ConfigureWeaponSlot:
			return_array.append(item)
			
	return return_array
			


func _on_button_pressed():
	for weapon_slot in get_weapon_slots():
		weapon_slot.add_mods_to_weapon()
