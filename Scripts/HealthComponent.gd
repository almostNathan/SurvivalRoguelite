extends Node2D
class_name HealthComponent

signal zero_hp
signal health_change
signal set_max_hp

@export var max_health = 10
var health : float

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	set_max_hp.emit(max_health)
	

func damage(damage_dealt):
	health -= damage_dealt
	if health <= 0:
		emit_signal("zero_hp")
	else:
		emit_signal("health_change", health)
