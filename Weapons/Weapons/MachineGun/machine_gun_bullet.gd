extends BaseBullet
class_name MachineGunBullet

func _init():
	speed = 1400

func _physics_process(delta):
	setting_movement_direction.emit(self)
	var velocity_vector = movement_direction_vector * current_speed * delta
	position += velocity_vector
	#var collision = move_and_collide(velocity_vector)
	#if collision:
		#if collision.get_collider() is TileMap:
			#queue_free()

func set_movement_direction(aiming_direction: Vector2):
	movement_direction_vector = aiming_direction
	self.rotate(aiming_direction.angle())



