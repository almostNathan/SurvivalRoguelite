extends BaseBullet
class_name ScytheBullet


var rotation_speed = 5

func _physics_process(delta):
	rotate(rotation_speed * delta)
	position = player.position

