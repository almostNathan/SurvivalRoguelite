extends BaseEnemyMod

@export var exp_value = 10
var experience = preload("res://Pickups/Experience/experience.tscn")

func _ready():
	super()
	enemy.on_death.connect(on_death)

	
func on_death():
	var new_exp = experience.instantiate()
	new_exp.position = enemy.position
	enemy.add_sibling(new_exp)
	
	
