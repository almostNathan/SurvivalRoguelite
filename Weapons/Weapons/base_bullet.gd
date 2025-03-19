extends Area2D
class_name BaseBullet

signal on_hit(body)
signal shooting_weapon()
signal setting_movement_direction(body)

var speed = 700.0
var current_speed = speed

@onready var hitbox = $Hitbox
@onready var weapon_image : Sprite2D = $Sprite
@onready var lifespan_timer : Timer = $LifespanTimer


var delete_bullet = false
var movement_direction_vector : Vector2
var weapon
var player
var enemies_hit = 0
var enemies_pierced = 0
var enemies_bounced = 0


#Bullet Modifier Variables
var area_modifier = 1
var projectile_speed_modifier = 1


func _physics_process(delta):
	setting_movement_direction.emit(self)
	var velocity_vector = movement_direction_vector * current_speed * delta
	position += velocity_vector
	#var collision = move_and_collide(velocity_vector)
	#if collision:
		#if collision.get_collider() is TileMap:
			#queue_free()
	#apply spin to bullet image
	weapon_image.rotate(PI/16)

func _on_body_entered(body):
	delete_bullet = true
	if body is TileMap:
		queue_free()
	elif body.has_method("hit") && body.is_in_group("enemy"):
		enemies_hit += 1
		weapon.hit(body, self)
		if (delete_bullet):
			queue_free()

func set_movement_direction(aiming_direction: Vector2):
	movement_direction_vector = aiming_direction

func modify_movement_direction(change_in_radians):
	movement_direction_vector = movement_direction_vector.rotated(change_in_radians)

func set_weapon(new_weapon):
	self.weapon = new_weapon

func set_player(new_player):
	player = new_player

func _on_on_screen_enabler_screen_exited():
	queue_free()

func _on_lifespan_timer_timeout():
	queue_free()

func set_area_modifier(new_modifier):
	scale *= new_modifier
	
func set_projectile_speed_modifier(new_modifier):
	projectile_speed_modifier = new_modifier
	calculate_current_speed()
	
func calculate_current_speed():
	current_speed = speed * projectile_speed_modifier

func set_duration_modifier(new_modifier):
	if lifespan_timer != null:
		lifespan_timer.wait_time *= new_modifier


