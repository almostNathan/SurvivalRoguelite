extends TextureRect
class_name WeaponSlot

@onready var margin_container = $MarginContainer
@onready var mod_grid = $ModGrid
@onready var weapon_image = margin_container.get_child(0)
@onready var lock_image = preload("res://Art/hud_assets/lock_icon.png")

var player : CharacterBody2D
var weapon_in_slot : BaseWeapon

func _ready():
	update_weapon_slot()

func put_weapon(weapon : BaseWeapon):
	self.visible = true
	weapon_in_slot = weapon
	weapon.adding_mod.connect(added_mod)
	update_weapon_slot()
	
func update_weapon_slot():
	if weapon_in_slot != null:
		margin_container.rotation_degrees = 45
		weapon_image.texture = weapon_in_slot.find_child("Image").texture
		for item in mod_grid.get_children():
			item.queue_free()
		for mod in weapon_in_slot.get_mod_list():
			var mod_slot = preload("res://ConfigMenu/configure_mod_slot.tscn").instantiate()
			mod_slot.custom_minimum_size = Vector2(self.size.x/3, self.size.y/3)
			mod_grid.add_child(mod_slot)
			mod_slot.set_mod_in_slot(mod)
	else:
		margin_container.rotation_degrees = 0
		weapon_image.texture = lock_image

func added_mod(mod_added):
	update_weapon_slot()
