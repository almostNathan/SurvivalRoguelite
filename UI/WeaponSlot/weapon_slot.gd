extends Panel
class_name WeaponSlot

@onready var margin_container = $MarginContainer
@onready var weapon_image = margin_container.get_child(0)
@onready var lock_image = preload("res://Art/hud_assets/lock_icon.png")

var player : CharacterBody2D
var weapon_in_slot : BaseWeapon

func _ready():
	update_weapon_slot()

func put_weapon(weapon : BaseWeapon):
	self.visible = true
	weapon_in_slot = weapon
	update_weapon_slot()
	
func update_weapon_slot():
	if weapon_in_slot != null:
		margin_container.rotation_degrees = 45
		weapon_image.texture = weapon_in_slot.find_child("Image").texture
	else:
		margin_container.rotation_degrees = 0
		weapon_image.texture = lock_image
