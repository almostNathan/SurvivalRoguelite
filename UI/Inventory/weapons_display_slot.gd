extends MarginContainer

@onready var image :TextureRect = $TextureRect
@onready var mod_slot_label : Label = $ModSlotLabel

var weapon_in_slot

func set_weapon_in_slot(weapon : BaseWeapon):
	weapon_in_slot = weapon
	image.texture = weapon.get_icon()
	mod_slot_label.text = str(len(weapon.mod_list)) + ' / ' + str(weapon.total_mod_slots)


