extends BaseMonster
class_name FloatingEye

#Attacks in a straigt line, quickly

func _ready():
	super()
	wait_timer.start()

	

func move(delta):
	if move_timer.is_stopped():
		sprite.animation = "idle"
	else:
		sprite.animation = "moving"
		var direction = Vector2.UP.rotated(movement_direction)
		position += direction * max_speed * delta
		position.clamp(Vector2.ZERO, get_parent().get_level_size())



func set_movement_direction(direction):
	#only change aiming direction while still
	if move_timer.is_stopped():
		movement_direction = direction
