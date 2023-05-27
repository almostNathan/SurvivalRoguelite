extends Node2D

var max_health = 100
var cur_health = max_health

func damage(value):
	cur_health -= value
	if cur_health <= 0:
		cur_health = 0
	elif cur_health >= max_health:
		cur_health = max_health

