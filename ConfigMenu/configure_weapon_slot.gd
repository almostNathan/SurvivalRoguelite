extends TextureRect
class_name ConfigureWeaponSlot

@onready var mod_grid = $WeaponModGridContainer
var weapon_in_slot : BaseWeapon
var moddable = true

func _get_drag_data(at_position):
	set_drag_preview(self.duplicate())
	if get_parent().name == "WeaponGridContainer":
		queue_free()
	return weapon_in_slot.duplicate()



func _drop_data(at_position, data):
	if data is BaseMod:
		var mod_slot = preload("res://ConfigMenu/configure_mod_slot.tscn").instantiate()
		mod_grid.add_child(mod_slot)
		mod_slot.size = Vector2(self.size.x/3, self.size.y/3)
		mod_slot.set_mod_in_slot(data)
	elif data is BaseWeapon:
		set_weapon_in_slot(data)

func _can_drop_data(at_position, data):
	return true if moddable else false

func set_weapon_in_slot(weapon):
	weapon_in_slot = weapon
	$Icon.texture = weapon.get_icon()
	texture = null
	


func _on_button_pressed():
	for mod_slot in mod_grid.get_children():
		print("adding ", mod_slot.get_mod(), " to ", weapon_in_slot)
		weapon_in_slot.add_mod(mod_slot.get_mod())

