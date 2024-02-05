extends BaseEnemyMod
class_name DropLootMod

var loot_scene = preload("res://Pickups/Loot/loot.tscn")

func _ready():
	super()
	enemy.connect("on_death", on_death, CONNECT_ONE_SHOT)

func on_death():
	var loot = loot_scene.instantiate()
	loot.position = enemy.position
	enemy.add_sibling(loot)
