extends BaseMonster
class_name Slime

func _ready():
	super()
	wait_timer.start()
	
func move(delta):
	if !move_timer.is_stopped():
		sprite.animation = "moving"
		var direction = Vector2.UP.rotated(movement_direction)
		position += direction * max_speed * delta
		position.clamp(Vector2.ZERO, get_parent().get_level_size())
	else:
		sprite.animation = "idle"

