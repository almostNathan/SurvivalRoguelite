extends Node

#
#Monster List
#
var slime = preload("res://Enemies/Slime/slime.tscn")
var mushroom = preload("res://Enemies/Mushroom/mushroom.tscn")
var floating_eye = preload("res://Enemies/FloatingEye/floating_eye.tscn")
var skeleton = preload("res://Enemies/Skeleton/skeleton.tscn")
var goblin = preload("res://Enemies/Goblin/goblin.tscn")

#
#Boss List
#
var slime_boss = preload("res://Enemies/Bosses/SlimeBoss/slime_boss.tscn")

var boss_pool = [slime_boss]

var level_0_enemy_pool = [ goblin]
var level_1_enemy_pool = [mushroom, floating_eye]
var level_2_enemy_pool = [slime, mushroom, floating_eye]
var level_3_enemy_pool = [slime, mushroom, floating_eye, skeleton]
var level_4_enemy_pool = [slime, mushroom, floating_eye, skeleton]

var enemy_pool_array = [level_0_enemy_pool, level_1_enemy_pool, level_2_enemy_pool]


