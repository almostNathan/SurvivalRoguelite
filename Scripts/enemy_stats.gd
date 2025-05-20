extends Node

func get_stats(enemy_name: String):
	return enemy_dict[enemy_name]
	#if enemy is Slime:
		#return slime
	#elif enemy is FloatingEye:
		#return floating_eye
	#elif enemy is Goblin:
		#return goblin
	#elif enemy is Mushroom:
		#return mushroom
	#elif enemy is Skeleton:
		#return skeleton
	#elif enemy is SlimeBoss:
		#return slime_boss

var slime = {
	"max_health" : 20,
	"max_speed" : 150,
	"spawn_value" : 10,
	"base_damage" : 10,
	"exp_value" : 11
}

var floating_eye = {
	"max_health" : 10,
	"max_speed" : 200,
	"spawn_value" : 10,
	"base_damage" : 10,
	"exp_value" : 12
}

var goblin = {
	"max_health" : 30,
	"max_speed" : 150,
	"spawn_value" : 20,
	"base_damage" : 10,
	"exp_value" : 13
}

var mushroom = {
	"max_health" : 50,
	"max_speed" : 100,
	"spawn_value" : 10,
	"base_damage" : 20,
	"exp_value" : 14
}

var skeleton = {
	"max_health" : 30,
	"max_speed" : 150,
	"spawn_value" : 15,
	"base_damage" : 20,
	"exp_value" : 14
}

var slime_boss = {
	"max_health" : 200,
	"max_speed" : 150,
	"spawn_value" : 100,
	"base_damage" : 50,
	"exp_value" : 110
}

var enemy_dict :Dictionary = {
	"slime": slime,
	"floating_eye": floating_eye,
	"goblin": goblin,
	"mushroom": mushroom,
	"skeleton": skeleton,
	"slime_boss": slime_boss
}
