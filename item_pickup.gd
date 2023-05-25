extends Area2D

@export var loot : PackedScene
var is_lootable = true

func _ready():
	pass


func _process(delta):
	pass


func _on_body_entered(body):
	if is_lootable:
		body.toggle_lootable(self)


func _on_body_exited(body):
		body.untoggle_lootable(self)
	
	
func get_loot():
	is_lootable = false
	return loot
