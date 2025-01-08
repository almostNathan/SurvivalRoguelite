extends BaseBullet
class_name MachineGunBullet

func _init():
	speed = 1400

func _physics_process(delta):
	setting_movement_direction.emit(self)
	position += movement_direction_vector * current_speed * delta

func set_movement_direction(aiming_direction: Vector2):
	movement_direction_vector = aiming_direction
	self.rotate(aiming_direction.angle())

func _on_body_entered(body):
	super(body)

