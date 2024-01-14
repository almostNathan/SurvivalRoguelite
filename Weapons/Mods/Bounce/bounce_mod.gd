extends BulletMod
class_name BounceMod

func _ready():
	super()
	parent.on_hit.connect(_on_hit)
	

func _on_hit(body):
	if parent is BaseBullet:
		if parent.delete_bullet == true:
			parent.modify_movement_direction(PI)
			#parent.rotation = parent.position.angle_to_point(body.global_position)-PI
			parent.delete_bullet = false
			parent.remove_child(self)
			queue_free()


