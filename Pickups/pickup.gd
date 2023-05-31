extends Area2D

var is_lootable = true


func _on_body_entered(body):
	if is_lootable and body.has_method("toggle_lootable"):
		body.toggle_lootable(self)


func _on_body_exited(body):
	if body.has_method("toggle_lootable"):
		body.untoggle_lootable(self)
	
