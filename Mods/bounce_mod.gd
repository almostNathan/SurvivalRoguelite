extends Node2D
class_name Bounce

var weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	weapon = get_parent()
	weapon.on_hit.connect(_on_hit)
	
func get_copy():
	var return_mod = load("res://Mods/bounce_mod.tscn")
	
	return return_mod.instan
	

func _on_hit(body):
	print("bouncing")
	var return_projectile = get_parent().duplicate()
	return_projectile.remove_mod(self)
	return_projectile.rotation = weapon.position.angle_to_point(body.global_position)-PI/2
	


