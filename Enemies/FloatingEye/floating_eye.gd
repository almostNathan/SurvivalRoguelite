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

func hit(weapon_stats):
	super(weapon_stats)
	$AnimatedSprite.play('hit')
	$AnimatedSprite.self_modulate = Color(1,0,0,1)
	await get_tree().create_timer(.5).timeout
	$AnimatedSprite.self_modulate = Color(1,1,1,1)


func _on_animated_sprite_animation_finished():
	$AnimatedSprite.play('idle')
	$AnimatedSprite.self_modulate = Color(1,1,1,1)
