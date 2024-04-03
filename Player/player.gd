extends CharacterBody2D
class_name Player

signal equipping_weapon(weapon)
signal health_changed
signal gain_experience(exp_amount)
signal shooting_weapon(bullet)
signal set_max_health(new_max_hp)
signal health_change(cur_health)

var main_weapon_scene : PackedScene
var offhand_weapon_scene : PackedScene
@export var max_speed = 250.0

@onready var main_weapon : BaseWeapon
@onready var offhand_weapon : BaseWeapon

@onready var player_animation = $PlayerAnimation
@onready var player_collision = $PlayerCollision
@onready var health = $Health
@onready var i_frame_timer = $IFrameTimer
@onready var dodge_timer = $DodgeTimer
@onready var player_hud = $PlayerHud
@onready var inventory = $PlayerHud/Inventory

#Modifier variables
var weapon_spread = PI/4
#In Radians
var aiming_direction : Vector2
var current_experience = 0

var max_health = 100
var cur_health = 100

#Character movement variables
var speed = max_speed
var dodge_speed = max_speed * 2
var acceleration = 1500.0
var friction = 1200.0

var mod_inventory = []
var weapon_inventory = []

func _ready():
	Globals.player = self
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("dodge"):
		if dodge_timer.is_stopped():
			dodge()
	var nearby_areas = $MagnetArea.get_overlapping_areas()
	for area in nearby_areas:
		if area.has_method("magnet_to_player"):
			area.magnet_to_player(self)
	move(delta)

func dodge():
	speed = dodge_speed
	player_collision.disabled = true
	i_frame_timer.start()
	dodge_timer.start()

func angle_to_mouse():
	return position.angle_to_point(get_global_mouse_position()) + PI/2

func equip_main(weapon : BaseWeapon):
	weapon_inventory.append(weapon)
	main_weapon = weapon
	self.add_child(main_weapon)
	equipping_weapon.emit(main_weapon)
	Hud.inventory.add_weapon(main_weapon)
	main_weapon.modify_attack_speed_mult(.15)

func equip_offhand(weapon : BaseWeapon):
	weapon_inventory.append(weapon)
	offhand_weapon = weapon
	equipping_weapon.emit(offhand_weapon)
	self.add_child(offhand_weapon)
	Hud.inventory.add_weapon(offhand_weapon)

func move(delta):
	var movement_direction = Vector2.ZERO
	
	#Define the movement vector
	movement_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	movement_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))

	#Change animation based on movement vector
	if movement_direction.x > 0:
		player_animation.animation = "right"
	else:
		player_animation.animation = "left"
	if movement_direction != Vector2.ZERO:
		movement_direction = movement_direction.normalized()
		$PlayerAnimation.play()
	else:
		apply_friction(friction*delta)
	
	velocity += movement_direction * acceleration * delta
	velocity = velocity.limit_length(speed)
	move_and_slide()
	position.clamp(Vector2.ZERO, get_parent().get_level_size())

func apply_friction(current_friction):
	if velocity.length() > current_friction:
		velocity -= velocity.normalized() * current_friction
	else:
		velocity = Vector2.ZERO
		$PlayerAnimation.stop()

func take_experience(new_exp : float):
	gain_experience.emit(new_exp)

func _on_hitbox_body_entered(body):
	if body.has_method("deal_damage") && i_frame_timer.is_stopped():
		take_damage(body.deal_damage())


func _on_i_frame_timer_timeout():
	player_collision.disabled = false
	speed = max_speed

func set_aiming_direction(closest_enemy_position):
	var angle_to_closest_enemy = position.angle_to_point(closest_enemy_position)
	aiming_direction = Vector2.RIGHT.rotated(angle_to_closest_enemy)

func take_damage(amount):
	health.take_damage(amount)
	emit_signal("health_changed", health.cur_health)

func lose_life(amount):
	health.lose_life(amount)
	emit_signal("health_changed", health.cur_health)

func gain_life(amount):
	health.gain_life(amount)
	emit_signal("health_changed", health.cur_health)

func trigger_loot(_loot_scene_list):
	Hud.level_up()

func add_to_inventory(item):
	mod_inventory.append(item)
	
func level_up():
	Hud.level_up()

