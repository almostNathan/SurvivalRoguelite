extends Node
class_name BaseDebuff

signal duration_timeout(debuff)

var parent : CharacterBody2D
var weapon
var debuff_icon = preload("res://icon.svg")

func _ready():
	parent = get_parent()

func set_weapon(new_weapon):
	weapon = new_weapon


func _on_duration_timer_timeout():
	duration_timeout.emit(self)
