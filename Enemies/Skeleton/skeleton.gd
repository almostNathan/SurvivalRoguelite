extends BaseEnemy
class_name Skeleton

var total_rotation = 0

func move(delta):
	super(delta)
	total_rotation += delta*2
	velocity = velocity.rotated(sin(total_rotation)/10)
