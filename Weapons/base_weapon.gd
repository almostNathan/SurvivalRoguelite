extends Area2D

signal on_hit(body)

@export var speed = 700.0
@export var damage = 5.0
@export var knockback = 100.0


@onready var hitbox = $Hitbox
@onready var sprite = $Sprite
@onready var cooldown_timer = $WeaponTimer
@onready var on_screen_enabler = $OnScreenEnabler
@onready var attack : Attack

var size_modifier = 1
var damage_modifier = 1
var bounce_amount = 0
var pierce_amount = 0


func _ready():
	attack = Attack.new()
	attack.attack_damage = damage
	attack.knockback_force = knockback
	

func _physics_process(delta):
	var direction = Vector2.UP.rotated(rotation)
	position += direction * speed * delta
	sprite.rotate(PI/16)


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func put_on_cooldown():
	$WeaponTimer.start()


func get_cooldown():
	print($WeaponTimer.wait_time)
	return $WeaponTimer.wait_time

func off_cooldown():
	return $WeaponTimer.is_stopped()

func after_hit_effects():
	pass

func apply_modifiers(weapon_upgrades : Upgrade):
	damage_modifier *= weapon_upgrades.damage_mult
	size_modifier *= weapon_upgrades.size_mult
	bounce_amount += weapon_upgrades.bounce_cnt
	attack.attack_damage *= damage_modifier
	scale *= weapon_upgrades.size_mult
	
func get_effect():
	pass

func get_sprite_texture():
	return $Sprite.texture

func _on_body_entered(body):
	if body.has_method("hit") && body.is_in_group("enemy"):
		on_hit.emit(body)
		body.hit(attack)
		after_hit_effects()
		if bounce_amount > 0:
			bounce_amount -= 1
			rotation = position.angle_to_point(body.global_position)-PI/2
		else:
			queue_free()
	
