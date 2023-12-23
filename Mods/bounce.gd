extends Node
class_name Bounce

var weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	weapon = get_parent()
	weapon.on_hit.connect(_on_hit)
	

func _on_hit(body):
	weapon.rotation = weapon.position.angle_to_point(body.global_position)-PI/2


