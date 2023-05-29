extends Area2D
class_name Stone

@export var speed = 700.0
@export var damage = 5.0
@export var knockback = 100.0


@onready var hitbox = $Hitbox
@onready var sprite = $Sprite
@onready var weapon_timer = $WeaponTimer
@onready var on_screen_enabler = $OnScreenEnabler

var size_modifier = 1
var damage_modifier = 1

func _onready():
	scale = size_modifier

func _physics_process(delta):
	var direction = Vector2.UP.rotated(rotation)
	position += direction * speed * delta
	sprite.rotate(PI/16)


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func put_on_cooldown():
	$WeaponTimer.start()


func get_cooldown():
	return $WeaponTimer.wait_time

func off_cooldown():
	return $WeaponTimer.is_stopped()

func after_hit_effects():
	pass

func get_effect():
	pass

func _on_body_entered(body):
	if body.has_method("hit") && body.is_in_group("enemy"):
		var attack = Attack.new()
		attack.attack_damage = damage
		attack.knockback_force = knockback
		body.hit(attack)
		after_hit_effects()
		queue_free()
	
