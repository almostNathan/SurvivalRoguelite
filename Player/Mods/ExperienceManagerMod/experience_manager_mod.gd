extends Node
class_name ExperienceManagerMod
#increases damage done, Max HP, HP Regen

signal level_up_damage(damage_increase)

var player
var exp_total = 0.0
var player_level : int = 1
var exp_scaling = 1.1
var cur_damage_scaling = 1.0
var cur_hp_scaling = 1.0
var cur_regen_scaling = 1.0

var damage_scaling_per_level = .1
var hp_scaling_per_level = .1
var hp_regen_scaling_per_level = .1

var exp_map = []

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()
	create_exp_map()
	player.gain_experience.connect(add_experience)
	player.equipping_weapon.connect(connect_to_weapon)

func add_experience(amount):
	exp_total += amount
	check_cur_level()

func check_cur_level():
	for level in range(len(exp_map)):
		if exp_map[level] > exp_total:
			if level > player_level:
				print("expmodman levelup")
				increase_stats(level - player_level)
				level_up_damage.emit(cur_damage_scaling-1)
				player_level = level
				return
			else:
				return

func increase_stats(num_of_times):
	cur_damage_scaling = cur_damage_scaling * pow((1 + damage_scaling_per_level),num_of_times) 

func create_exp_map():
	var cur_total_exp : int = 100
	exp_map.append(-1)
	for i in range(100):
		exp_map.append(cur_total_exp)
		cur_total_exp = cur_total_exp + cur_total_exp * exp_scaling

func connect_to_weapon(weapon : BaseWeapon):
	level_up_damage.connect(Callable(weapon, "modify_damage_mult"))
