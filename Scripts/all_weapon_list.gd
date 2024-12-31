extends Node
class_name WeaponsList

var weapon_scene_list : Array = [
	preload("res://Weapons/Weapons/Stick/stick_weapon.tscn"),
	preload("res://Weapons/Weapons/Stone/stone_weapon.tscn"),
	preload("res://Weapons/Weapons/Scythe/scythe_weapon.tscn"),
	preload("res://Weapons/Weapons/MagicBook/magic_book_weapon.tscn"),
	preload("res://Weapons/Weapons/Aura/aura_weapon.tscn"),
	preload("res://Weapons/Weapons/Boomerang/boomerang_weapon.tscn"),
	preload("res://Weapons/Weapons/Turret/turret_weapon.tscn"),
	preload("res://Weapons/Weapons/Laser/laser_weapon.tscn"),
	preload("res://Weapons/Weapons/MachineGun/machine_gun_weapon.tscn")
]

var available_weapon_scene_list : Array = weapon_scene_list.duplicate()

func remove_weapon_from_pool(node):
	var available_weapons = AllWeaponList.available_weapon_scene_list
	for scene in available_weapons:
		if scene.resource_path == node.scene_file_path:
			available_weapons.remove_at(available_weapons.find(scene))
