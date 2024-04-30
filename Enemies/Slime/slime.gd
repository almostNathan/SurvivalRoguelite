extends BaseEnemy
class_name Slime

func _ready():
	super()
	wait_timer.start()

func move(delta):
	if move_timer.is_stopped():
		sprite.animation = "idle"
		velocity = Vector2.ZERO
	else:
		var direction = Vector2.UP.rotated(movement_direction)
		velocity += direction * acceleration * delta
		sprite.animation = "moving"


