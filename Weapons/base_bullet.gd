extends Area2D
class_name BaseBullet

signal on_hit(body)
signal shooting_weapon()

@export var speed = 700.0
@export var damage = 5.0

@onready var hitbox = $Hitbox
@onready var weapon_image = $Sprite
@onready var on_screen_enabler = $OnScreenEnabler
var delete_bullet = false

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	weapon_image.rotate(PI/16)

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	delete_bullet = true
	print("base bullet onbodyentered")
	if body.has_method("hit") && body.is_in_group("enemy"):
		on_hit.emit(body)
		if (delete_bullet):
			queue_free()

func add_mod(mod_to_add):
	add_child(mod_to_add)
