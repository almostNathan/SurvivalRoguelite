extends Node
class_name ModList

var mod_scene_list = [
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

var player_mod_data = [
	{
		"name" : "Base",
		"scene_path" : "none",
		"rarity" : "none",
		"tags" : [
			"none"
		]
	},
	{
		"name" : "Increased Area of Effect",
		"scene_path" : "res://Player/Mods/AreaPlayerMod/area_player_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"area"
		]
	},
	{
		"name" : "Increased Attack Speed",
		"scene_path" : "res://Player/Mods/AttackSpeedPlayerMod/attack_speed_player_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"attack speed", "speed"
		]
	},
	{
		"name" : "Increased Damage",
		"scene_path" : "res://Player/Mods/DamagePlayerMod/damage_player_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"damage"
		]
	},
	{
		"name" : "Increased Deploy Speed",
		"scene_path" : "res://Player/Mods/DeploySpeedPlayerMod/deploy_speed_player_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"area"
		]
	},
	{
		"name" : "Increased Dodge Speed",
		"scene_path" : "res://Player/Mods/DodgeSpeedPlayerMod/dodge_speed_player_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"area"
		]
	},
	{
		"name" : "Increased Duration",
		"scene_path" : "res://Player/Mods/IncreasedDurationPlayerMod/increased_duration_player_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"area"
		]
	},
	{
		"name" : "Incresed Experience",
		"scene_path" : "res://Player/Mods/IncreasedExperiencePlayerMod/increased_experience_player_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"area"
		]
	},
	{
		"name" : "Incresed Magnet Radius",
		"scene_path" : "res://Player/Mods/MagnetRadiusPlayerMod/magnet_radius_player_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"area"
		]
	},
	{
		"name" : "Increased Move Speed",
		"scene_path" : "res://Player/Mods/MoveSpeedPlayerMod/movespeed_player_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"area"
		]
	},
	{
		"name" : "Incresed Projectile Speed",
		"scene_path" : "res://Player/Mods/ProjectileSpeedPlayerMod/projectile_speed_player_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"area"
		]
	},
	{
		"name" : "Time Capsule",
		"scene_path" : "res://Player/Mods/TimeCapsulePlayerMod/time_capsule_player_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"area"
		]
	},
	{
		"name" : "WASD",
		"scene_path" : "res://Player/Mods/WASDPlayerMod/wasd_player_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"area"
		]
	}
]


var mod_data = [
	{
		"name" : "Base",
		"scene_path" : "none",
		"rarity" : "none",
		"tags" : [
			"none"
		]
	},
	{
		"name" : "Added Damage",
		"scene_path" : "res://Weapons/Mods/AddedDamage/added_damage_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"damage"
		]
	},
	{
		"name" : "Split",
		"scene_path" : "res://Weapons/Mods/AddProj/add_proj_mod.tscn",
		"rarity" : "rare",
		"tags" : [
			"projectile"
		]
	},
	{
		"name" : "Attack Speed",
		"scene_path" : "res://Weapons/Mods/AttackSpeed/attack_speed_mod.tscn",
		"rarity" : "uncommon",
		"tags" : [
			"speed", "attack speed"
		]
	},
	{
		"name" : "Bounce",
		"scene_path" : "res://Weapons/Mods/Bounce/bounce_mod.tscn",
		"tooltip_text" : "Adds +%d damage to modified weapon.",
		"rarity" : "uncommon",
		"tags" : [
			"projectile"
		]
	},
	{
		"name" : "Burn",
		"scene_path" : "res://Weapons/Mods/Burn/burn_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"damage", "fire"
		]
	},
	{
		"name" : "Chain",
		"scene_path" : "res://Weapons/Mods/Chain/chain_mod.tscn",
		"rarity" : "uncommon",
		"tags" : [
			"projectile"
		]
	},
	{
		"name" : "Damage",
		"scene_path" : "res://Weapons/Mods/Damage/damage_mod.tscn",
		"rarity" : "starter",
		"tags" : [
			
		]
	},
	{
		"name" : "Explode on Death",
		"scene_path" : "res://Weapons/Mods/ExplodeOnDeath/explode_on_death_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"death", "damage", "area"
		]
	},
	{
		"name" : "Increased Damage",
		"scene_path" : "res://Weapons/Mods/IncreasedDamage/increased_damage_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"damage"
		]
	},
	{
		"name" : "Leech",
		"scene_path" : "res://Weapons/Mods/Leech/leech_mod.tscn",
		"rarity" : "rare",
		"tags" : [
			"health"
		]
	},
	{
		"name" : "Pierce",
		"scene_path" : "res://Weapons/Mods/Pierce/pierce_mod.tscn",
		"rarity" : "uncommon",
		"tags" : [
			"projectile"
		]
	},
	{
		"name" : "Poison",
		"scene_path" : "res://Weapons/Mods/Poison/poison_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"damage", "poison"
		]
	},
	{
		"name" : "Poison Cloud on Death",
		"scene_path" : "res://Weapons/Mods/PoisonCloud/poison_cloud_mod.tscn",
		"rarity" : "legendary",
		"tags" : [
			"death", "poison", "area"
		]
	},
	{
		"name" : "Splash",
		"scene_path" : "res://Weapons/Mods/Splash/splash_mod.tscn",
		"rarity" : "uncommon",
		"tags" : [
			"damage", "area"
		]
	},
	{
		"name" : "Time Bomb",
		"scene_path" : "res://Weapons/Mods/TimeBomb/time_bomb_mod.tscn",
		"rarity" : "common",
		"tags" : [
			"damage", 'time'
		]
	}
]



var player_mod_scene_list = [
	preload("res://Player/Mods/DamagePlayerMod/damage_player_mod.tscn"),
	preload("res://Weapons/Mods/IncreasedDamage/increased_damage_mod.tscn"),
	preload("res://Weapons/Mods/AddedDamage/added_damage_mod.tscn")
]

