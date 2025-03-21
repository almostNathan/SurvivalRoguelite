extends BaseEnemyMod
class_name ExperienceMod

var exp_value = 10
var experience = preload("res://Pickups/Experience/experience.tscn")

func _ready():
	super()
	enemy.connect("on_death", on_death, CONNECT_ONE_SHOT)


	
func on_death():
	var new_exp = experience.instantiate()
	new_exp.exp_value = enemy.exp_value
	new_exp.position = enemy.position
	enemy.call_deferred("add_sibling", new_exp)
	

