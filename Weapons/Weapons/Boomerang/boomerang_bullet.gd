extends BaseBullet
class_name BoomerangBullet

var rotation_in_radians = .05

func _physics_process(delta):
	super(delta)
	modify_movement_direction(rotation_in_radians)
