extends BaseEnemy
class_name FloatingEye

#Attacks in a straigt line, quickly

func _ready():
	super()
	wait_timer.start()

func move(delta):
	if move_timer.is_stopped():
		sprite.animation = "idle"
		velocity = Vector2.ZERO
	else:
		sprite.animation = "moving"
		var direction = Vector2.UP.rotated(movement_direction)
		velocity += direction * acceleration * delta

func set_movement_direction(direction):
	#only change aiming direction while still
	if move_timer.is_stopped():
		movement_direction = direction
