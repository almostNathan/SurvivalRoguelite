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
	var new_weapon = weapon.duplicate()
	new_weapon.remove_child(new_weapon.find_child("BounceMod"))
	weapon.add_sibling(new_weapon)
	new_weapon.rotation = weapon.position.angle_to_point(body.global_position)-PI
	


