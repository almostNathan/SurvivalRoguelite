extends BaseEnemy
class_name Skeleton


func move(delta):
	super(delta)
	velocity = velocity.rotated(.1)
