extends CharacterBody2D
class_name BaseEnemy

signal set_max_health(max_health)
signal on_death()
signal on_physics_process(delta)

@export var max_health : float
@export var max_speed = 75.0

@onready var health_comp = $HealthComponent
@onready var health_bar = $HealthBar
@onready var move_timer = $MoveTimer
@onready var wait_timer = $WaitTimer
@onready var sprite = $AnimatedSprite

var effect_queue = []

var acceleration = 1500.0
var friction = 1200.0
var move_distance = 1000.0
@onready var movement_direction : float = 0.0

var damage_output = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle")
	set_max_health.emit(max_health)
	health_comp.health = max_health
	health_bar.max_value = max_health
	health_bar.value = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#apply effect of all mods recently applied to enemy
	for mod in effect_queue:
		mod.call_deferred("apply_effect", self)
	effect_queue = []
	
	on_physics_process.emit(delta)
	
	if !$AnimatedSprite.is_playing():
		$AnimatedSprite.play("idle")
	move(delta)
	
func hit(damage : DamageMod):
	health_comp.damage(damage.damage_value)

func take_damage(damage_amount):
	health_comp.damage(damage_amount)

func _on_health_component_zero_hp():
	print("Base_enemy onhealthcomponentzerohp")
	on_death.emit()
	queue_free()
	
func move(delta):
	var direction = Vector2.UP.rotated(movement_direction)
	position += direction * max_speed * delta
	position.clamp(Vector2.ZERO, get_parent().get_level_size())

func set_movement_direction(direction : float):
	movement_direction = direction

func add_to_mod_queue(mod_to_add):
	effect_queue.append(mod_to_add)

func deal_damage():
	return damage_output

func _on_move_timer_timeout():
	wait_timer.start()

func _on_wait_timer_timeout():
	move_timer.start()

func add_mod(mod_to_add):
	self.add_child(mod_to_add)

