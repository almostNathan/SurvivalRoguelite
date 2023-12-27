extends Panel


@onready var margin_container = $MarginContainer
@onready var weapon_image = margin_container.get_child(0)
@onready var applied_mods = $AppliedMods
@onready var available_mod_slots = $AvailableModSlots


var player : CharacterBody2D
var weapon_in_slot : BaseWeapon

func _ready():
	player = get_parent().get_parent()
	player.equip_main_weapon_slot.connect(put_weapon)

func put_weapon(weapon : BaseWeapon):
	weapon_in_slot = weapon
	update_weapon_slot()
	
func update_weapon_slot():
	weapon_image.texture = weapon_in_slot.get_child(1).texture
	applied_mods.text = str(weapon_in_slot.current_mod_count)
	available_mod_slots.text = str(weapon_in_slot.available_mod_slots)
	
