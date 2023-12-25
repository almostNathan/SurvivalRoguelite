extends Area2D
class_name BaseWeapon

signal on_hit(body)
signal shooting_weapon()

@export var speed = 700.0
@export var damage = 5.0
@export var knockback = 100.0
@export var shooting_angle = PI


@onready var hitbox = $Hitbox
@onready var sprite = $Sprite
@onready var weapon_timer = $WeaponTimer
@onready var on_screen_enabler = $OnScreenEnabler
var delete_bullet = false



func _ready():
	pass
	

func _physics_process(delta):
	speed = 700
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	sprite.rotate(PI/16)


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func put_on_cooldown():
	$WeaponTimer.start()


func get_cooldown():
	return $WeaponTimer.wait_time

	
func get_effect():
	pass

func get_sprite_texture():
	return $Sprite.texture

func _on_body_entered(body):
	delete_bullet = true
	if body.has_method("hit") && body.is_in_group("enemy"):
		on_hit.emit(body)
		if (delete_bullet):
			queue_free()

func add_mod(mod_to_add):
	add_child(mod_to_add)

func shoot_weapon(player_position, player_aiming_direction):
	shooting_weapon.emit()
	global_position = player_position
	rotation = player_aiming_direction


