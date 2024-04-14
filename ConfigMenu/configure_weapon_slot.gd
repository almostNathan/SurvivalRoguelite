extends TextureRect
class_name ConfigureWeaponSlot

signal mod_placed_in_weapon()

@onready var mod_grid = $WeaponModGridContainer
@onready var weapon_icon = $Icon
var weapon_in_slot : BaseWeapon
var moddable = false
var open = true

func _get_drag_data(_at_position):
	set_drag_preview(self.duplicate())
	if get_parent().name == "WeaponGridContainer":
		queue_free()
	return weapon_in_slot.duplicate()



func _drop_data(_at_position, data):
	if data is BaseMod:
		var mod_slot = preload("res://ConfigMenu/configure_mod_slot.tscn").instantiate()
		mod_grid.add_child(mod_slot)
		mod_slot.custom_minimum_size = Vector2(self.size.x/3, self.size.y/3)
		mod_slot.set_mod_in_slot(data)
		mod_placed_in_weapon.emit()
	elif data is BaseWeapon:
		set_weapon_in_slot(data)

func _can_drop_data(_at_position, data):
	if open and data is BaseWeapon:
		return true
	if moddable and data is BaseMod:
		return true


func set_weapon_in_slot(weapon):
	weapon_in_slot = weapon
	$Icon.texture = weapon.get_icon()
	texture = null
	open = false
	moddable = true

func remove_weapon_in_slot():
	weapon_in_slot = null
	weapon_icon.texture = null
	texture = preload("res://Art/hud_assets/icon_background.png")
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
		for mod_slot in mod_grid.get_children():
			mod_slot.queue_free()
	if weapon_in_slot.get_children().has(DamageMod) or weapon_in_slot.get_children().has(PoisonMod) or weapon_in_slot.get_children().has(BurnMod) or weapon_in_slot.get_children().has(SplashMod):
		pass
	else:
		weapon_in_slot.add_mod(preload("res://Weapons/Mods/Damage/damage_mod.tscn").instantiate())
