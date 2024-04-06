extends Node2D

var max_health = 100
var cur_health = max_health

func take_damage(value):
	cur_health -= value
	if cur_health <= 0:
		cur_health = 0
	elif cur_health >= max_health:
		cur_health = max_health
	
	check_for_death()
	update_hud()

func lose_life(value):
	cur_health -= value
	if cur_health <= 0:
		cur_health = 0
	elif cur_health >= max_health:
		cur_health = max_health
	check_for_death()
	update_hud()

func gain_life(value):
	cur_health += value
	if cur_health <= 0:
		cur_health = 0
	elif cur_health >= max_health:
		cur_health = max_health
	update_hud()

func update_hud():
	Hud.health_bar.value = cur_health
	Hud.health_bar.max_value = max_health

func check_for_death():
	if cur_health <= 0:
		Hud.game_over()

func heal_to_full():
	cur_health = max_health
	update_hud()
