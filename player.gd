extends CharacterBody2D

signal equip_main_weapon_slot(weapon)
signal health_changed
signal gain_experience(exp_amount)
signal shooting_weapon(bullet)

@export var main_weapon_scene : PackedScene
@export var offhand_weapon_scene : PackedScene
@export var max_speed = 250.0

@onready var main_weapon = main_weapon_scene.instantiate()
@onready var offhand_weapon = offhand_weapon_scene.instantiate()

@onready var main_weapon_timer = $MainWeaponTimer 
@onready var offhand_weapon_timer = $OffhandWeaponTimer 
@onready var player_animation = $PlayerAnimation
@onready var player_collision = $PlayerCollision
@onready var health = $Health
@onready var i_frame_timer = $IFrameTimer
@onready var dodge_timer = $DodgeTimer
@onready var player_hud = $PlayerHud

#Modifier variables
var weapon_spread = PI/4
var aiming_direction = 0
var current_experience = 0


#Character movement variables
var speed = max_speed
var dodge_speed = max_speed * 2
var acceleration = 1500.0
var friction = 1200.0


func _ready():
	equip_main(main_weapon_scene)
	equip_offhand(offhand_weapon_scene)
	#main_weapon_timer.start()
	#offhand_weapon_timer.start()

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
	i_frame_timer.start()
	dodge_timer.start()
	

func angle_to_mouse():
	return position.angle_to_point(get_global_mouse_position()) + PI/2

#Evenly divide projectiles across attack spread


##TODO: add changing weaponcooldown icons
func equip_main(weapon : PackedScene):
	var new_main_weapon = weapon.instantiate()
	equip_main_weapon_slot.emit(new_main_weapon)
	main_weapon_timer.wait_time = new_main_weapon.get_cooldown()
	main_weapon = new_main_weapon
	player_hud.change_main_weapon(new_main_weapon)

func equip_offhand(weapon : PackedScene):
	var new_offhand_weapon = weapon.instantiate()
	offhand_weapon_timer.wait_time = new_offhand_weapon.get_cooldown()
	offhand_weapon_timer.wait_time *= 1.25
	offhand_weapon = new_offhand_weapon
	player_hud.change_offhand_weapon(new_offhand_weapon)



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
	if body.has_method("damage"):
		health.damage(body.damage())
		emit_signal("health_changed", health.cur_health)


func _on_i_frame_timer_timeout():
	speed = max_speed

func set_aiming_direction(closest_enemy_position):
	aiming_direction = position.angle_to_point(closest_enemy_position)
	
	

func _on_offhand_weapon_timer_timeout():
	var bullet = offhand_weapon_scene.instantiate()
	shooting_weapon.emit(bullet)
	add_sibling(bullet)
	bullet.shoot_weapon(position,aiming_direction)



func _on_main_weapon_timer_timeout():
	var bullet = main_weapon_scene.instantiate()
	shooting_weapon.emit(bullet)
	add_sibling(bullet)
	bullet.shoot_weapon(position,aiming_direction)

