extends CharacterBody2D
class_name BaseEnemy

signal set_max_health(max_health)
signal on_death()

@export var max_health : float
@export var max_speed = 75.0

@onready var health_comp = $HealthComponent
@onready var health_bar = $HealthBar
@onready var move_timer = $MoveTimer
@onready var wait_timer = $WaitTimer
@onready var sprite = $AnimatedSprite

var acceleration = 1500.0

var friction = 1200.0
var move_distance = 1000.0
@onready var movement_direction : float = 0.0
var damage_output = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	set_base_stats()
	$AnimatedSprite.play("idle")
	set_max_health.emit(max_health)
	health_comp.health = max_health
	health_bar.max_value = max_health
	health_bar.value = max_health

	
func set_base_stats():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !$AnimatedSprite.is_playing():
		$AnimatedSprite.play("idle")
	move(delta)
	
func hit(damage : DamageMod):
	health_comp.damage(damage.damage_value)


func _on_health_component_zero_hp():
	on_death.emit()
	queue_free()

func move(delta):
	var direction = Vector2.UP.rotated(movement_direction)
	position += direction * max_speed * delta
	position.clamp(Vector2.ZERO, get_parent().get_level_size())

func set_movement_direction(direction : float):
	movement_direction = direction

func deal_damage():
	return damage_output

func _on_move_timer_timeout():
	wait_timer.start()

func _on_wait_timer_timeout():
	move_timer.start()


