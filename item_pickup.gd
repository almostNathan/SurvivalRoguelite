extends Area2D

@export var loot : PackedScene
var is_lootable = true

func _ready():
	pass


func _process(delta):
	pass


func _on_body_entered(body):
	if is_lootable and body.has_method("toggle_lootable"):
		body.toggle_lootable(self)


func _on_body_exited(body):
	if body.has_method("untoggle_lootable"):
		body.untoggle_lootable(self)
	
	
func get_loot():
	is_lootable = false
	return loot
