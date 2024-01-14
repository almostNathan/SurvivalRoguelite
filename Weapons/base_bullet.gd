extends Area2D
class_name BaseBullet

signal on_hit(body)
signal shooting_weapon()
signal setting_movement_direction(body)

@export var speed = 700.0
@export var damage = 5.0

@onready var hitbox = $Hitbox
@onready var weapon_image = $Sprite
@onready var on_screen_enabler = $OnScreenEnabler
var delete_bullet = false
var movement_direction : Vector2

func _physics_process(delta):
	setting_movement_direction.emit(self)
	position += movement_direction * speed * delta
	
	#apply spin to bullet image
	weapon_image.rotate(PI/16)

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	delete_bullet = true
	if body.has_method("hit") && body.is_in_group("enemy"):
		on_hit.emit(body)
		if (delete_bullet):
			queue_free()

func add_mod(mod_to_add):
	add_child(mod_to_add)
	
func set_movement_direction(aiming_direction: Vector2):
	movement_direction = aiming_direction

func modify_movement_direction(change_in_radians):
	movement_direction = movement_direction.rotated(change_in_radians)
