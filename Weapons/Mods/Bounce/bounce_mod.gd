extends BaseMod
class_name Bounce

var bounce_count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	weapon.on_hit.connect(_on_hit)

func _on_hit(body):
	#var new_weapon = weapon.duplicate()
	#new_weapon.remove_child(new_weapon.find_child("BounceMod"))
	#weapon.add_sibling(new_weapon)
	var bounce_mods_on_weapon = weapon.find_children("BounceMod")
	print(len(bounce_mods_on_weapon))
	if bounce_count < len(bounce_mods_on_weapon):
		weapon.rotation = weapon.position.angle_to_point(body.global_position)-PI
		weapon.delete_bullet = false
		bounce_count += 1
	


