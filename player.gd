extends CharacterBody2D

signal fire_main_weapon
signal health_changed

@export var main_weapon_scene : PackedScene
@export var offhand_weapon_scene : PackedScene
@export var max_speed = 250.0

@onready var main_weapon = main_weapon_scene.instantiate()
@onready var offhand_weapon = offhand_weapon_scene.instantiate()

@onready var main_weapon_timer = $MainWeaponTimer 
@onready var offhand_weapon_timer = $OffhandWeaponTimer 
@onready var player_animation = $PlayerAnimation
@onready var player_collision = $PlayerCollision
@onready var loot_sprite = $LootableSprite
@onready var health = $Health
@onready var i_frame_timer = $IFrameTimer
@onready var dodge_timer = $DodgeTimer
@onready var player_hud = $PlayerHud

#Modifier variables
var weapon_upgrades = Upgrade.new()
var weapon_spread = PI/4

#Array for nearby lootable 
#TODO add way to cycle thru lootables
var lootable_list : Array

#Character movement variables
var speed = max_speed
var dodge_speed = max_speed * 2
var acceleration = 1500.0
var friction = 1200.0


func _ready():
	weapon_upgrades.set_base_stats()
	weapon_upgrades.projectile_cnt = 1
	equip_main(main_weapon_scene)
	equip_offhand(offhand_weapon_scene)

func _physics_process(delta):
	#Shooting weapons
	if Input.is_action_just_pressed("left_click"):
		shoot_weapon("main_weapon")
	if Input.is_action_just_pressed("right_click"):
		shoot_weapon("offhand_weapon")
	if Input.is_action_just_pressed("interact"):
		interact_with_object()
	if Input.is_action_just_pressed("dodge"):
		if dodge_timer.is_stopped():
			dodge()

	move(delta)

func dodge():
	speed = dodge_speed
	i_frame_timer.start()
	dodge_timer.start()
	


func angle_to_mouse():
	return position.angle_to_point(get_global_mouse_position()) + PI/2

#
# Shooting the weapon
#
func shoot_weapon(weapon_slot):
	var bullet_array = Array()

	if weapon_slot == "main_weapon":
		if main_weapon_timer.is_stopped():
			main_weapon_timer.start()
			player_hud.main_weapon_cooldown()
			for i in range(weapon_upgrades.projectile_cnt):
				bullet_array.append(main_weapon_scene.instantiate())
		else:
			return
	if weapon_slot == "offhand_weapon":
		if offhand_weapon_timer.is_stopped():
			offhand_weapon_timer.start()
			player_hud.offhand_weapon_cooldown()
			for i in range(weapon_upgrades.projectile_cnt):
				bullet_array.append(offhand_weapon_scene.instantiate())
		else: 
			return

	for bullet in bullet_array:
		get_parent().add_child(bullet)
		bullet.global_position = position
		bullet.apply_modifiers(weapon_upgrades)
	set_bullet_spread(bullet_array)
	
#Evenly divide projectiles across attack spread
func set_bullet_spread(bullet_array : Array):
	var mouse_pos = angle_to_mouse()
	var left_side = mouse_pos - weapon_spread/2
	var num_bullets = bullet_array.size()
	for i in range(num_bullets):
		bullet_array[i].rotation = left_side + (i+1)*(weapon_spread/(num_bullets+1))


func interact_with_object():
	if !lootable_list.is_empty():
		var new_loot = lootable_list[0]
		if new_loot.has_method("take_upgrade"):
			var new_upgrade = new_loot.take_upgrade()
			apply_upgrade(new_upgrade)
			new_loot.queue_free()
		if new_loot.has_method("equip_weapon"):
			equip_main(new_loot)

##TODO: add changing weaponcooldown icons
func equip_main(weapon : PackedScene):
	var new_weapon = weapon.instantiate()
	main_weapon_timer.wait_time = new_weapon.get_cooldown()
	main_weapon = new_weapon
	player_hud.change_main_weapon(new_weapon)

func equip_offhand(weapon : PackedScene):
	var new_weapon = weapon.instantiate()
	offhand_weapon_timer.wait_time = new_weapon.get_cooldown()
	main_weapon = new_weapon
	player_hud.change_offhand_weapon(new_weapon)
	
	
#notify player when object nearby can be interacted with
func toggle_lootable(loot_object):
	loot_sprite.visible = true
	lootable_list.append(loot_object)
	
func untoggle_lootable(loot_object):
	loot_sprite.visible = false
	lootable_list.pop_at(lootable_list.find(loot_object))


func apply_upgrade(new_upgrade : Upgrade):
	weapon_upgrades.damage_mult *= new_upgrade.damage_mult
	weapon_upgrades.speed_mult *= new_upgrade.speed_mult
	weapon_upgrades.attack_speed_mult *= new_upgrade.attack_speed_mult
	weapon_upgrades.size_mult *= new_upgrade.size_mult
	weapon_upgrades.projectile_cnt += new_upgrade.projectile_cnt
	weapon_upgrades.bounce_cnt += new_upgrade.bounce_cnt
	
	#change current weapon cooldwon based on upgrade alone
	#Future weapons will be modified by the weapon_upgrades.attack_speed_mult when equipped
	main_weapon_timer.wait_time /= new_upgrade.attack_speed_mult
	offhand_weapon_timer.wait_time /= new_upgrade.attack_speed_mult
	

	

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


func _on_hitbox_body_entered(body):
	if body.has_method("damage"):
		health.damage(body.damage())
		emit_signal("health_changed", health.cur_health)


func _on_i_frame_timer_timeout():
	speed = max_speed
