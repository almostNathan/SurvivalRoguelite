extends Node
class_name BaseDebuff

var parent : CharacterBody2D
var weapon

func _ready():
	parent = get_parent()

func set_weapon(new_weapon):
	weapon = new_weapon
