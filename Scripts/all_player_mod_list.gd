extends Node
class_name PlayerModList

var player_mod_scene_list = [
	preload("res://Player/Mods/DamagePlayerMod/damage_player_mod.tscn"),
	preload("res://Player/Mods/MoveSpeedPlayerMod/movespeed_player_mod.tscn"),
	preload("res://Player/Mods/AttackSpeedPlayerMod/attack_speed_player_mod.tscn"),
	preload("res://Player/Mods/AreaPlayerMod/area_player_mod.tscn"),
	preload("res://Player/Mods/DeploySpeedPlayerMod/deploy_speed_player_mod.tscn"),
	preload("res://Player/Mods/ProjectileSpeedPlayerMod/projectile_speed_player_mod.tscn"),
	preload("res://Player/Mods/MagnetRadiusPlayerMod/magnet_radius_player_mod.tscn"),
	preload("res://Player/Mods/DodgeSpeedPlayerMod/dodge_speed_player_mod.tscn"),
	preload("res://Player/Mods/IncreasedExperiencePlayerMod/increased_experience_player_mod.tscn"),
	preload("res://Player/Mods/IncreasedDurationPlayerMod/increased_duration_player_mod.tscn"),
	preload("res://Player/Mods/TimeCapsulePlayerMod/time_capsule_player_mod.tscn")
]
