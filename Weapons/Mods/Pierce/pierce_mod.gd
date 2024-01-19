extends BulletMod
class_name PierceMod

func _ready():
	super()
	parent.on_hit.connect(_on_hit)
	

func _on_hit(_body):
	if parent is BaseBullet:
		if parent.delete_bullet == true:
			parent.delete_bullet = false
			queue_free()


