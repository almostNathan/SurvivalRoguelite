extends BaseBullet
class_name BoomerangBullet

var rotation_in_radians = .05


func _physics_process(delta):
	super(delta)
	modify_movement_direction(rotation_in_radians)

func _on_body_entered(body):
	if body.has_method("hit") && body.is_in_group("enemy"):
		enemies_hit += 1
		weapon.hit(body, self)
