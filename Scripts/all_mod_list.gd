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

#TODO change scene to scene_path and change from preload to string that is loaded at runtime
var mod_data = [
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
			"speed"
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

