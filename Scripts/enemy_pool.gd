extends Node

#
#Monster List
#
var slime = preload("res://Enemies/Slime/slime.tscn")
var mushroom = preload("res://Enemies/Mushroom/mushroom.tscn")
var floating_eye = preload("res://Enemies/FloatingEye/floating_eye.tscn")
var skeleton = preload("res://Enemies/Skeleton/skeleton.tscn")

var level_0_enemy_pool = [slime,skeleton]
var level_1_enemy_pool = [mushroom, floating_eye]
var level_2_enemy_pool = [slime, mushroom, floating_eye]

var enemy_pool_array = [level_0_enemy_pool, level_1_enemy_pool, level_2_enemy_pool]


