extends Node
class_name ExperienceManagerMod

var player
var exp_total = 0
var player_level : int = 1
var level_damage_scaling = .01
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()
	player.gain_experience.connect(add_experience)
	player.shooting_weapon.connect(add_level_modifier)

func add_experience(amount):
	exp_total += amount
	print(exp_total)
	player_level = (exp_total/100) +1
	

func add_level_modifier(weapon : BaseWeapon):
	var weapon_damage_mod = weapon.find_child("DamageMod")
	var level_multi = float(player_level-1) * level_damage_scaling
	weapon_damage_mod.damage_multiplier(1+level_multi)
	

