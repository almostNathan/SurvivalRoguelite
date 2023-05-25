extends CharacterBody2D

signal fire_main_weapon


@export var main_weapon_scene : PackedScene
@export var offhand_weapon_scene : PackedScene

@onready var main_weapon = main_weapon_scene.instantiate()
@onready var offhand_weapon = offhand_weapon_scene.instantiate()

@onready var main_weapon_timer = $MainWeaponTimer 
@onready var offhand_weapon_timer = $OffhandWeaponTimer 
@onready var player_animation = $PlayerAnimation
@onready var player_collision = $PlayerCollision
@onready var loot_sprite = $LootableSprite


var lootable_list : Array
var acceleration = 1500.0
var max_speed = 250.0
var friction = 1200.0

	
func angle_to_mouse():
	return position.angle_to_point(get_global_mouse_position())+ PI/2
	


#TODO: cooldown not working for weapons.
func shoot_weapon(weapon_slot):
	var weapon
	var new_bullet

	if weapon_slot == "main_weapon":
		if main_weapon.off_cooldown():
			main_weapon.put_on_cooldown()
			weapon = main_weapon
			new_bullet = main_weapon_scene.instantiate()
		else:
			return
	if weapon_slot == "offhand_weapon":
		if offhand_weapon.off_cooldown():
			offhand_weapon.put_on_cooldown()
			weapon = offhand_weapon
			new_bullet = offhand_weapon_scene.instantiate()
		else: 
			return


	if weapon.off_cooldown():
		get_parent().add_child(new_bullet)
		new_bullet.global_position = position
		new_bullet.rotation = angle_to_mouse()
		weapon.put_on_cooldown()
		
		
#TODO add ducktyping to determine if weapon or usable
func interact_with_object():
	if !lootable_list.is_empty():
		var new_loot = lootable_list[0].get_loot()
		equip_main(new_loot)
		
func equip_main(weapon):
	main_weapon_scene = weapon
	var new_weapon = main_weapon_scene.instantiate()
	main_weapon_timer.wait_time = new_weapon.get_cooldown()
	main_weapon = new_weapon
	
func equip_offhand(weapon):
	offhand_weapon_scene = weapon
	var new_weapon = offhand_weapon_scene.instantiate()
	main_weapon_timer.wait_time = new_weapon.get_cooldown()
	main_weapon = new_weapon
	
	
#notify player when object nearby can be interacted with
func toggle_lootable(loot_object):
	loot_sprite.visible = true
	lootable_list.append(loot_object)
	
func untoggle_lootable(loot_object):
	loot_sprite.visible = false
	lootable_list.pop_at(lootable_list.find(loot_object))


func _physics_process(delta):
	var movement_direction = Vector2.ZERO
	
	#Define the movement vector
	movement_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	movement_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))

	#Change animation based on movement vector
	if movement_direction.x > 0:
		player_animation.animation = "right"
	else:
		player_animation.animation = "left"
	
	#Shooting weapons
	if Input.is_action_just_pressed("left_click"):
		shoot_weapon("main_weapon")
	if Input.is_action_just_pressed("right_click"):
		shoot_weapon("offhand_weapon")
	
	
	if Input.is_action_just_pressed("interact"):
		interact_with_object()
	
	
	if movement_direction != Vector2.ZERO:
		movement_direction = movement_direction.normalized()
		$PlayerAnimation.play()
	else:
		apply_friction(friction*delta)

	
	velocity += movement_direction * acceleration * delta
	velocity = velocity.limit_length(max_speed)
	move_and_slide()


func apply_friction(current_friction):
	if velocity.length() > current_friction:
		velocity -= velocity.normalized() * current_friction
	else:
		velocity = Vector2.ZERO
		$PlayerAnimation.stop()
