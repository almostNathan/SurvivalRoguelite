extends CharacterBody2D


@onready var health_comp = $HealthComponent

var acceleration = 1500.0
var max_speed = 250.0
var friction = 1200.0
var move_distance = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !$AnimatedSprite.is_playing():
		$AnimatedSprite.play("idle")
	
func hit(attack : Attack):
	health_comp.damage(attack.attack_damage)


func _on_health_component_zero_hp():
	queue_free()

func move():
	


func _on_move_timer_timeout():
	move()
