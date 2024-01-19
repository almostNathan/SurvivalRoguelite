extends BulletMod
class_name BounceMod

func _ready():
	super()
	parent.on_hit.connect(_on_hit)
	

func _on_hit(body):
	if parent is BaseBullet:
		if parent.delete_bullet == true:
			parent.modify_movement_direction(PI)
			parent.delete_bullet = false
			queue_free()


