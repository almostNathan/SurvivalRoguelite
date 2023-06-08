extends "res://Enemies/base_monster.gd"

func _ready():
	wait_timer.start()
	
func move(delta):
	if !move_timer.is_stopped():
		sprite.animation = "moving"
		movement_direction = Vector2.UP.rotated(movement_direction)
		position += movement_direction * max_speed * delta
		position.clamp(Vector2.ZERO, get_parent().get_level_size())
	else:
		sprite.animation = "idle"

