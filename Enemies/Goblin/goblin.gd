extends BaseEnemy
class_name Goblin

func _ready():
	super()
	$AnimatedSprite.play("moving")




func move(delta):
	super(delta)
	#var clamped_distance_to_player = clamp((self.position.distance_to(Globals.player.position) - 300), 2, 500)
	if self.position.distance_to(Globals.player.position) < 200:
		velocity = velocity.rotated(PI/4)
