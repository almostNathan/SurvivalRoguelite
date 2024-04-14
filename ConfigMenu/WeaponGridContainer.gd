extends GridContainer

func get_weapon_slots():
	var return_array : Array
	for item in get_children():
		if item is ConfigureWeaponSlot:
			return_array.append(item)
			
	return return_array
			
