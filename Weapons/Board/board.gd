extends "res://Weapons/stone.gd"
class_name Board

func after_hit_effects():
	var effect = get_effect()
	var instance = effect.instantiate()
	get_parent().call_deferred("add_child", instance)
	instance.position = position
	var animation = instance.get_node("Animation")
	animation.play()
	
	
	
func get_effect():
	return preload("res://Weapons/Effects/explosion.tscn")
