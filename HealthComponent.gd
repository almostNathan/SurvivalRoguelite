extends Node2D
class_name HealthComponent

signal zero_hp
signal health_change

@export var MAX_HEALTH = 10
var health : float

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH

func damage(damage_dealt):
	health -= damage_dealt
	if health <= 0:
		emit_signal("zero_hp")
	else:
		emit_signal("health_change",)
