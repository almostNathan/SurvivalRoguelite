extends Area2D
class_name BaseBullet

signal on_hit(body)
signal shooting_weapon()
signal setting_movement_direction(body)

@export var speed = 700.0


@onready var hitbox = $Hitbox
@onready var weapon_image = $Sprite
@onready var on_screen_enabler = $OnScreenEnabler

var delete_bullet = false
var movement_direction : Vector2
var weapon
var player
var enemies_hit = 0
var enemies_pierced = 0
var enemies_bounced = 0

func _physics_process(delta):
	setting_movement_direction.emit(self)
	position += movement_direction * speed * delta
	
	#apply spin to bullet image
	weapon_image.rotate(PI/16)

func _on_body_entered(body):
	delete_bullet = true
	if body.has_method("hit") && body.is_in_group("enemy"):
		enemies_hit += 1
		weapon.emit_signal("on_hit", body, self)
		if (delete_bullet):
			queue_free()

func add_mod(mod_to_add):
	add_child(mod_to_add)
	
func set_movement_direction(aiming_direction: Vector2):
	movement_direction = aiming_direction

func modify_movement_direction(change_in_radians):
	movement_direction = movement_direction.rotated(change_in_radians)
	
func set_weapon(new_weapon):
	self.weapon = new_weapon
	
func set_player(new_player):
	player = new_player


func _on_on_screen_enabler_screen_exited():
	queue_free()
