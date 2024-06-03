extends BaseEnemyMod
class_name DropLootMod

var loot_scene = preload("res://Pickups/Loot/loot.tscn")
var loot_scene_list

func _ready():
	super()
	enemy.connect("on_death", on_death, CONNECT_ONE_SHOT)

func on_death():
	var loot  : Loot = loot_scene.instantiate()
	if loot_scene_list != null:
		loot.set_loot_scene_list(loot_scene_list)
	loot.position = enemy.position
	enemy.add_sibling(loot)


func set_loot_scene_list(new_loot_scene_list : Array):
	loot_scene_list = new_loot_scene_list
