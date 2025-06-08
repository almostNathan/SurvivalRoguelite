class_name LoadoutOptions


var player_variant : Dictionary = {
	"weapon" = MachineGunWeapon.new(),
	"additional_weapons" = [
		preload("res://Weapons/Weapons/Laser/laser_weapon.tscn")
		,preload("res://Weapons/Weapons/Aura/aura_weapon.tscn")
		,preload("res://Weapons/Weapons/Boomerang/boomerang_weapon.tscn")
	],
	"weapon_scene" = preload("res://Weapons/Weapons/MachineGun/machine_gun_weapon.tscn"),
	"player_mod_list" = [
		preload("res://Player/Mods/WASDPlayerMod/wasd_player_mod.tscn")
	],
	"mod_list" = [
	preload("res://Weapons/Mods/AddProj/add_proj_mod.tscn"),
	preload("res://Weapons/Mods/AddProj/add_proj_mod.tscn")
	]
}

var test : Dictionary = {
	"weapon" = MachineGunWeapon.new(),
	"weapon_scene" = preload("res://Weapons/Weapons/MachineGun/machine_gun_weapon.tscn"),
	"mod_list" = [
	preload("res://Weapons/Mods/AddProj/add_proj_mod.tscn"),
	preload("res://Weapons/Mods/AddProj/add_proj_mod.tscn"),
	preload("res://Weapons/Mods/Bounce/bounce_mod.tscn"),
	preload("res://Weapons/Mods/Burn/burn_mod.tscn"),
	preload("res://Weapons/Mods/AttackSpeed/attack_speed_mod.tscn"),
	preload("res://Weapons/Mods/Leech/leech_mod.tscn"),
	preload("res://Weapons/Mods/Pierce/pierce_mod.tscn"),
	preload("res://Weapons/Mods/Poison/poison_mod.tscn"),
	preload("res://Weapons/Mods/Splash/splash_mod.tscn"),
	preload("res://Weapons/Mods/TimeBomb/time_bomb_mod.tscn"),
	preload("res://Weapons/Mods/ExplodeOnDeath/explode_on_death_mod.tscn"),
	preload("res://Weapons/Mods/PoisonCloud/poison_cloud_mod.tscn"),
	preload("res://Weapons/Mods/IncreasedDamage/increased_damage_mod.tscn"),
	preload("res://Weapons/Mods/AddedDamage/added_damage_mod.tscn"),
	preload("res://Weapons/Mods/Chain/chain_mod.tscn")
]
}

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

var starting_loadouts_list = [player_variant, test, stone, machine_gun, orb, turret]


