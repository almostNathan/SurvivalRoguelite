extends CharacterBody2D
class_name BaseEnemy

signal set_max_health(max_health)
signal on_death()
signal on_physics_process(delta)
signal health_change(cur_health)
signal moving(velocity, delta)



@export var max_health : float
@export var max_speed : float
var cur_health : float
@export var exp_value = 10

@onready var health_bar = $HealthBar
@onready var move_timer = $MoveTimer
@onready var wait_timer = $WaitTimer
@onready var sprite = $AnimatedSprite
@onready var debuff_bar = $DebuffBar

var effect_queue : Array = []
var debuff_array : Array = []
var acceleration = 1500
var speed = max_speed
var friction = 1200.0
var move_distance = 1000.0
@onready var movement_direction : float = 0.0


var elite_scaling_hp_modifier = 5.0
var elite_scaling_damage_modifier = 5.0

@export var base_damage = 10



# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play("idle")
	cur_health = max_health
	sprite.scale = Vector2(2,2)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#apply effect of all mods recently applied to enemy
	for mod in effect_queue:
		mod.call_deferred("apply_effect", self)
	effect_queue = []
	
	on_physics_process.emit(delta)
	
	if !sprite.is_playing():
		sprite.play("idle")
	move(delta)
	velocity = velocity.limit_length(max_speed)
	moving.emit(velocity, delta)
	move_and_slide()
	

func hit(weapon_stats : Dictionary):
	if cur_health > 0:
		cur_health -= weapon_stats['damage']
		if cur_health <= 0:
			weapon_stats['weapon'].on_kill.emit(self)
			on_death.emit()
			queue_free()
		else:
			health_change.emit(cur_health)

func lose_life(weapon, damage_amount):
	if cur_health > 0:
		cur_health -= damage_amount
		if cur_health <= 0:
			weapon.on_kill.emit(self)
			on_death.emit()
			queue_free()
		else:
			health_change.emit(cur_health)

	
func move(delta):
	var direction = Vector2.UP.rotated(movement_direction)
	velocity += direction * acceleration * delta
	

func set_movement_direction(direction : float):
	movement_direction = direction

func add_to_mod_queue(mod_to_add):
	effect_queue.append(mod_to_add)

func deal_damage():
	return base_damage

func _on_move_timer_timeout():
	wait_timer.start()

func _on_wait_timer_timeout():
	move_timer.start()

func add_mod(mod_to_add):
	self.add_child(mod_to_add)

func add_debuff(debuff : BaseDebuff):
	debuff_array.append(debuff)
	debuff_bar.update_debuff_bar(debuff_array)
	add_child(debuff)
	debuff.duration_timeout.connect(remove_debuff)

func remove_debuff(debuff):
	debuff_array.remove_at(debuff_array.find(debuff))
	debuff_bar.update_debuff_bar(debuff_array)
	debuff.queue_free()


func make_elite():
	var loot_mod = preload("res://Enemies/Mods/DropLoot/drop_loot_mod.tscn").instantiate()
	add_child(loot_mod)
	scale = Vector2(2,2)
	max_health = max_health * elite_scaling_hp_modifier
	base_damage = base_damage * elite_scaling_damage_modifier
	cur_health = max_health
	set_max_health.emit(max_health)
	health_change.emit(cur_health)

func modify_stats(modifiers):
	max_health = max_health * modifiers.health_modifier
	base_damage = base_damage * modifiers.damage_modifier
	max_speed *= modifiers.speed_modifier
	cur_health = max_health
	set_max_health.emit(max_health)
	health_change.emit(cur_health)
