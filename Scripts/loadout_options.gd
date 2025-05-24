class_name LoadoutOptions


var stone : Dictionary = {
	"weapon" = StoneWeapon.new(),
	"weapon_scene" = preload("res://Weapons/Weapons/Stone/stone_weapon.tscn"),
	"mod_list" = [preload("res://Weapons/Mods/Chain/chain_mod.tscn"),
		preload("res://Weapons/Mods/Pierce/pierce_mod.tscn")]
}

var machine_gun : Dictionary = {
	"weapon" = MachineGunWeapon.new(),
	"weapon_scene" = preload("res://Weapons/Weapons/MachineGun/machine_gun_weapon.tscn"),
	"mod_list" = [preload("res://Weapons/Mods/AddProj/add_proj_mod.tscn"),
		preload("res://Weapons/Mods/AddProj/add_proj_mod.tscn"),
		preload("res://Weapons/Mods/Chain/chain_mod.tscn")]
}

var orb : Dictionary = {
	"weapon" = OrbWeapon.new(),
	"weapon_scene" = preload("res://Weapons/Weapons/Orb/orb_weapon.tscn"),
	"mod_list" = [preload("res://Weapons/Mods/AddProj/add_proj_mod.tscn"),
		preload("res://Weapons/Mods/Splash/splash_mod.tscn")]
	
}

var turret : Dictionary = {
	"weapon" = TurretWeapon.new(),
	"weapon_scene" = preload("res://Weapons/Weapons/Turret/turret_weapon.tscn"),
	"mod_list" = [preload("res://Weapons/Mods/AddProj/add_proj_mod.tscn"),
		preload("res://Weapons/Mods/Poison/poison_mod.tscn")]
	
}

var starting_loadouts_list = [stone, machine_gun, orb, turret]
