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
	preload("res://Weapons/Mods/AddedDamage/added_damage_mod.tscn")
	#preload("res://Player/Mods/DamagePlayerMod/damage_player_mod.tscn")
]

var player_mod_scene_list = [
	preload("res://Player/Mods/DamagePlayerMod/damage_player_mod.tscn")
]

