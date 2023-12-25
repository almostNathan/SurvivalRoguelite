extends BaseMod
class_name PierceMod

func _ready():
	super()
	weapon.on_hit.connect(_on_hit)

func _on_hit(body):
	if weapon.delete_bullet == true:
		weapon.delete_bullet = false
		weapon.remove_child(self)
		queue_free()

