extends Node
class_name BaseEnemyMod

var enemy : BaseEnemy

func _ready():
	enemy = get_parent()
