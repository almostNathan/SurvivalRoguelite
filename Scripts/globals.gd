extends Node
var player : CharacterBody2D
var main_scene : MainScene

var mod_scene_list = [
	preload("res://Weapons/Mods/AddProj/add_proj_mod.tscn"),
	preload("res://Weapons/Mods/Bounce/bounce_mod.tscn"),
	preload("res://Weapons/Mods/Burn/burn_mod.tscn"),
	preload("res://Weapons/Mods/Crit/crit_mod.tscn"),
	preload("res://Weapons/Mods/Damage/damage_mod.tscn"),
	preload("res://Weapons/Mods/AttackSpeed/attack_speed_mod.tscn"),
	preload("res://Weapons/Mods/Leech/leech_mod.tscn"),
	preload("res://Weapons/Mods/Pierce/pierce_mod.tscn"),
	preload("res://Weapons/Mods/Poison/poison_mod.tscn"),
	preload("res://Weapons/Mods/Splash/splash_mod.tscn"),
	preload("res://Weapons/Mods/TimeBomb/time_bomb_mod.tscn"),
	preload("res://Weapons/Mods/ExplodeOnDeath/explode_on_death_mod.tscn"),
	preload("res://Weapons/Mods/PoisonCloud/poison_cloud_mod.tscn")
]

var weapon_scene_list = [
	preload("res://Weapons/Weapons/Stick/stick_weapon.tscn"),
	preload("res://Weapons/Weapons/Stone/stone_weapon.tscn"),
	preload("res://Weapons/Weapons/Scythe/scythe_weapon.tscn"),
	preload("res://Weapons/Weapons/MagicBook/magic_book_weapon.tscn"),
	preload("res://Weapons/Weapons/Aura/aura_weapon.tscn"),
	preload("res://Weapons/Weapons/Boomerang/boomerang_weapon.tscn"),
	preload("res://Weapons/Weapons/Turret/turret_weapon.tscn")

]
