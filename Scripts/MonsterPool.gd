class_name MonsterPool

#
#Monster List
#
var slime = preload("res://Enemies/Slime/slime.tscn")
var mushroom = preload("res://Enemies/Mushroom/mushroom.tscn")
var floating_eye = preload("res://Enemies/FloatingEye/floating_eye.tscn")

func get_monster_array():
	return [slime, mushroom, floating_eye]