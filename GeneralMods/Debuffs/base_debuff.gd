extends Node
class_name BaseDebuff

var parent : CharacterBody2D

func _ready():
	parent = get_parent()
