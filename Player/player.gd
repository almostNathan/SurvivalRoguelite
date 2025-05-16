extends CharacterBody2D
class_name Player

signal equipping_weapon(weapon)
signal health_changed
signal gain_experience(exp_amount)
signal shooting_weapon(bullet)
signal set_max_health(new_max_hp)
signal health_change(cur_health)
signal reset_game

@export var base_speed = 250.0

@onready var main_weapon : BaseWeapon
@onready var offhand_weapon : BaseWeapon

@onready var player_animation = $PlayerAnimation
@onready var player_collision = $PlayerCollision
@onready var health = $Health
@onready var i_frame_timer = $IFrameTimer
@onready var dodge_timer = $DodgeTimer
@onready var player_hud = $PlayerHud
@onready var exp_mod_man = $ExperienceManagerMod
@onready var magnet_area = $MagnetArea/MagnetHitbox

var save_name = "player"

#Modifier variables
var weapon_spread = PI/4
#In Radians
var aiming_direction : Vector2
var current_experience = 0

var max_health = 100
var cur_health = 100

#Character movement variables
var speed = base_speed
var dodge_speed = base_speed * 2
var acceleration = 1500.0
var friction = 1200.0
var base_magnet_radius = 200

var mod_inventory = []
var weapon_inventory = []
var player_mod_list = []
var interactable_list = []
var interactable_index = 0

#Modifier Variables
var speed_multiplier = 1
var dodge_speed_multiplier = 1
var magnet_raidus_multiplier = 1
var experience_multiplier = 1
var duration_multiplier = 1

func _ready():
	Globals.player = self

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
	speed = dodge_speed * speed_multiplier * dodge_speed_multiplier
	player_collision.disabled = true
	i_frame_timer.start()
	dodge_timer.start()

func angle_to_mouse():
	return position.angle_to_point(get_global_mouse_position()) + PI/2

func equip_weapons():
	for weapon in weapon_inventory:
		if !weapon.is_equipped:
			self.add_child(weapon)
			equipping_weapon.emit(weapon)

func reset_player():
	reset_game.emit()
	Globals.save_game()
	self.remove_child(main_weapon)
	self.remove_child(offhand_weapon)

	for weapon in weapon_inventory:
		weapon.queue_free()
	weapon_inventory = []
	for mod in mod_inventory:
		mod.queue_free()
	mod_inventory = []
	
	health.heal_to_full()
	exp_mod_man.reset_exp_mod_man()


func move(delta):
	var movement_direction = Vector2.ZERO
	
	#Define the movement vector
	movement_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	movement_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	
	if Input.is_action_just_pressed("interact"):
		if !interactable_list.is_empty():
			interactable_list[interactable_index].interact()

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
	velocity = velocity.limit_length(speed * speed_multiplier)
	move_and_slide()
	#position.clamp(Vector2.ZERO, get_parent().get_level_size())

func apply_friction(current_friction):
	if velocity.length() > current_friction:
		velocity -= velocity.normalized() * current_friction
	else:
		velocity = Vector2.ZERO
		$PlayerAnimation.stop()

func get_current_speed():
	return base_speed * speed_multiplier

func take_experience(new_exp : float):
	new_exp*= experience_multiplier
	gain_experience.emit(new_exp)

func _on_hitbox_body_entered(body):
	if body.has_method("deal_damage") && i_frame_timer.is_stopped():
		take_damage(body.deal_damage())


func _on_i_frame_timer_timeout():
	player_collision.disabled = false
	speed = base_speed

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

func add_to_inventory(item):
	mod_inventory.append(item)

func add_to_weapon_inventory(weapon):
	weapon_inventory.append(weapon)
	Hud.update_weapons_display()
	equip_weapons()
	refresh_player_mods()
	
func level_up():
	Hud.level_up()

func add_mod(mod_to_add:BasePlayerMod):
	mod_to_add.equip(self)
	player_mod_list.append(mod_to_add)

func remove_mod(mod_to_remove: BasePlayerMod):
	mod_to_remove.remove_mod()
	player_mod_list.remove_at(player_mod_list.find(self))

func detach_all_mods():

	for mod in player_mod_list:
		mod.remove_mod()
	player_mod_list = []

func refresh_player_mods():
	for mod in player_mod_list:
		mod.refresh()

func modify_speed_multiplier(change):
	speed_multiplier += change

func apply_player_mods_to_weapon(new_turret):
	for player_mod in player_mod_list:
		player_mod.apply_effect_to_weapon(new_turret)

func modify_magnet_radius_multiplier(modifier_change):
	magnet_raidus_multiplier += modifier_change
	magnet_area.shape.radius = base_magnet_radius * magnet_raidus_multiplier

func modify_dodge_speed_multiplier(modifier_change):
	dodge_speed_multiplier += modifier_change

func modify_experience_multiplier(modifier_change):
	experience_multiplier += modifier_change

func modify_duration_multiplier(modifier_change):
	duration_multiplier += modifier_change

func _on_interact_area_area_entered(area):
	if area.has_method("interact"):
		interactable_list.append(area)
	
func _on_interact_area_area_exited(area):
	if area.has_method("interact"):
		interactable_list.erase(area)

func get_all_weapon_mods_list():
	var return_mod_list = mod_inventory.duplicate()
	for weapon in weapon_inventory:
		return_mod_list.append_array(weapon.get_mod_list())
	
	return return_mod_list

func create_save_data():
	var mod_inventory_data = []
	for mod in mod_inventory:
		mod_inventory_data.append({
			"filename": mod.get_scene_file_path()
		})
	var rollover_mod_data = []
	for rollover_mod in Globals.player_data["rollover_mods"]:
		rollover_mod_data.append({
			"filename": rollover_mod.get_scene_file_path()
		})
	var save_data = {
		"mod_inventory": mod_inventory_data,
		"rollover_mods": rollover_mod_data
	}
	
	return save_data

func load_save_data(save_data):
	var player_save_data = save_data["player"]
	#for mod_data in player_save_data["mod_inventory"]:
		#add_to_inventory(load(mod_data["filename"]).instantiate())
	Globals.player_data["rollover_mods"] = []
	for rollover_mod_data in player_save_data["rollover_mods"]:
		Globals.player_data["rollover_mods"].append(load(rollover_mod_data["filename"]).instantiate())
