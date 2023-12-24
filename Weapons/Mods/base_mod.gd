extends Node2D
class_name BaseMod

var weapon : BaseWeapon

func _ready():
	weapon = get_parent()
