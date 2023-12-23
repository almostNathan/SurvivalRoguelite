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
	weapon.remove_child(self)
	var new_weapon = weapon.duplicate()
	print(weapon.get_children(), '\n')
	print(new_weapon.get_children())
	new_weapon.rotation = weapon.position.angle_to_point(body.global_position)-PI/2
	


